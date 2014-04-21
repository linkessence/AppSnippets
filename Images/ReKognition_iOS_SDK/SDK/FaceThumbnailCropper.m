//
//  FaceThumbnailCropper.m
//  ReKo SDK
//
//  Created by Kuang Han on 10/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import "FaceThumbnailCropper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@interface FaceThumbnailCropper()
@property (strong, nonatomic) NSMutableArray *rawFaceRectArray;
@property (strong, nonatomic) NSMutableArray *formattedFaceRectArray;
@end

@implementation FaceThumbnailCropper

const float THUMBNAIL_MAX_EDGE = 200.0;
const float MERGED_IMAGE_MAX_WIDTH = 800.0;


- (UIImage *)cropFaceThumbnailsInUIImage:(UIImage *)uiImage {
    [uiImage imageOrientation];
    NSData *imageData = UIImageJPEGRepresentation(uiImage, 1.0);
    return [self cropFaceThumbnailsInNSData:imageData];
}


- (UIImage *)cropFaceThumbnailsInNSData:(NSData *)imageData {
    CIImage *ciImage = [CIImage imageWithData:imageData];
    return [self cropFaceThumbnailsInCIImage:ciImage];
}


- (UIImage *)cropFaceThumbnailsInCIImage:(CIImage *)ciImage {
    CGFloat rawImageWidth = ciImage.extent.size.width;
    CGFloat rawImageHeight = ciImage.extent.size.height;
    
    NSDictionary *detectorOptions = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };
	CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    NSNumber* cgOrienation = [ciImage.properties objectForKey:(NSString*)kCGImagePropertyOrientation];
    NSLog(@"CGOrientation: %@", cgOrienation);
    if (cgOrienation == nil) {
        cgOrienation = @1;
    }    
    NSDictionary *imageOptions = @{ CIDetectorImageOrientation : cgOrienation};
    NSArray *features = [faceDetector featuresInImage:ciImage options:imageOptions];
    
    self.rawFaceRectArray = [NSMutableArray arrayWithCapacity:10];
    self.formattedFaceRectArray = [NSMutableArray arrayWithCapacity:10];
    int curX = 0, curY = 0, curRowHeight = 0, mergedImageWidth = 0, mergedImageHeight = 0;
    for (int i = 0; i < [features count]; i++) {
        NSLog(@"%d", i);
        CIFaceFeature *ff = features[i];
        
        CGFloat width = ff.bounds.size.width * 2;
        CGFloat height = ff.bounds.size.height * 2;
        CGFloat x0 = ff.bounds.origin.x - ff.bounds.size.width * 0.5;
        CGFloat y0 = ciImage.extent.size.height - ff.bounds.origin.y - ff.bounds.size.height * 1.7;
        CGFloat x1 = x0 + width;
        CGFloat y1 = y0 + height;
        x0 = (x0 < 0) ? 0 : x0;
        y0 = (y0 < 0) ? 0 : y0;
        x1 = (x1 > rawImageWidth) ? rawImageWidth : x1;
        y1 = (y1 > rawImageHeight) ? rawImageHeight : y1;
        width = x1 - x0;
        height = y1 - y0;
        CGRect rawFaceRect = CGRectMake(x0, y0, width, height);
        NSLog(@"raw: %f, %f, %f, %f", x0, y0, width, height);
        [self.rawFaceRectArray addObject:[NSValue valueWithCGRect:rawFaceRect]];
        
        CGSize formattedFaceSize = rawFaceRect.size;
        if (rawFaceRect.size.width > THUMBNAIL_MAX_EDGE || rawFaceRect.size.height > THUMBNAIL_MAX_EDGE) {
            if (rawFaceRect.size.width > rawFaceRect.size.height) {
                formattedFaceSize = CGSizeMake(THUMBNAIL_MAX_EDGE, rawFaceRect.size.height / rawFaceRect.size.width * THUMBNAIL_MAX_EDGE);
            } else {
                formattedFaceSize = CGSizeMake(rawFaceRect.size.width / rawFaceRect.size.height * THUMBNAIL_MAX_EDGE, THUMBNAIL_MAX_EDGE);
            }
        }
        
        if (curX + formattedFaceSize.width > MERGED_IMAGE_MAX_WIDTH) {
            // Break line.
            mergedImageWidth = MAX(mergedImageWidth, curX);
            curX = 0;
            curY += curRowHeight;
        }
        CGRect formattedFaceRect = CGRectMake(curX, curY, formattedFaceSize.width, formattedFaceSize.height);
        NSLog(@"formatted: %f, %f, %f, %f", formattedFaceRect.origin.x, formattedFaceRect.origin.y, formattedFaceRect.size.width, formattedFaceRect.size.height);
        [self.formattedFaceRectArray addObject:[NSValue valueWithCGRect:formattedFaceRect]];
        curRowHeight = MAX(curRowHeight, formattedFaceSize.height);
        curX += formattedFaceSize.width;
    }
    mergedImageWidth = MAX(mergedImageWidth, curX);
    mergedImageHeight = curY + curRowHeight;
    
    NSLog(@"%d, %d", mergedImageWidth, mergedImageHeight);
    UIGraphicsBeginImageContext(CGSizeMake(mergedImageWidth, mergedImageHeight));
    for (int i = 0; i < [self.rawFaceRectArray count]; i++) {
        CGRect rawFaceRect = [(NSValue *) self.rawFaceRectArray[i] CGRectValue];
        CGRect formattedFaceRect = [(NSValue *) self.formattedFaceRectArray[i] CGRectValue];
        CGRect ciRect = CGRectMake(rawFaceRect.origin.x, rawImageHeight - rawFaceRect.origin.y - rawFaceRect.size.height, rawFaceRect.size.width, rawFaceRect.size.height);
        CIImage *ciThumbnail = [ciImage imageByCroppingToRect:ciRect];
        UIImage *thumbnail = [UIImage imageWithCIImage:ciThumbnail];
        [thumbnail drawInRect:formattedFaceRect];
    }
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self saveUIImageToAlbum:mergedImage];
    
    return mergedImage;
}


- (void)correctFaceDetectResult:(RKFaceDetectResults *)faceDetectResult {
    for (FaceDetectItem *faceDetect in faceDetectResult.faceDetectOrALikeItems) {
        for (int i = 0; i < [self.formattedFaceRectArray count]; i++) {
            CGRect formattedRect = [(NSValue *)self.formattedFaceRectArray[i] CGRectValue];
            if (faceDetect.nose.x > formattedRect.origin.x &&
                faceDetect.nose.x < formattedRect.origin.x + formattedRect.size.width &&
                faceDetect.nose.y > formattedRect.origin.y &&
                faceDetect.nose.y < formattedRect.origin.y + formattedRect.size.height) {
                CGRect rawRect = [(NSValue *)self.rawFaceRectArray[i] CGRectValue];
                faceDetect.boundingbox = CGRectMake(
                                                    (faceDetect.boundingbox.origin.x - formattedRect.origin.x) / formattedRect.size.width * rawRect.size.width + rawRect.origin.x,
                                                    (faceDetect.boundingbox.origin.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y,
                                                    faceDetect.boundingbox.size.width / formattedRect.size.width * rawRect.size.width,
                                                    faceDetect.boundingbox.size.height / formattedRect.size.height * rawRect.size.height
                                                    );
                faceDetect.eye_left = CGPointMake(
                                                  (faceDetect.eye_left.x - formattedRect.origin.x) / formattedRect.size.width *rawRect.size.width + rawRect.origin.x,
                                                  (faceDetect.eye_left.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y
                                                  );
                faceDetect.eye_right = CGPointMake(
                                                   (faceDetect.eye_right.x - formattedRect.origin.x) / formattedRect.size.width *rawRect.size.width + rawRect.origin.x,
                                                   (faceDetect.eye_right.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y
                                                   );
                faceDetect.nose = CGPointMake(
                                              (faceDetect.nose.x - formattedRect.origin.x) / formattedRect.size.width *rawRect.size.width + rawRect.origin.x,
                                              (faceDetect.nose.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y
                                              );
                faceDetect.mouth_l = CGPointMake(
                                                 (faceDetect.mouth_l.x - formattedRect.origin.x) / formattedRect.size.width *rawRect.size.width + rawRect.origin.x,
                                                 (faceDetect.mouth_l.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y
                                                 );
                faceDetect.mouth_r = CGPointMake(
                                                 (faceDetect.mouth_r.x - formattedRect.origin.x) / formattedRect.size.width *rawRect.size.width + rawRect.origin.x,
                                                 (faceDetect.mouth_r.y - formattedRect.origin.y) / formattedRect.size.height * rawRect.size.height + rawRect.origin.y
                                                 );
                break;
            }
        }
    }
}


- (void)saveUIImageToAlbum:(UIImage *)image {
    CGImageRef cgImage = image.CGImage;
    BOOL releaseCGImage = NO;
    if (!cgImage) {
        CIContext *context = [CIContext contextWithOptions:nil];
        cgImage = [context createCGImage:image.CIImage fromRect:image.CIImage.extent];
        releaseCGImage = YES;
    }
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImage
                              orientation:0
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              if (releaseCGImage) {
                                  CGImageRelease(cgImage);
                              }
                          }];
}

@end
