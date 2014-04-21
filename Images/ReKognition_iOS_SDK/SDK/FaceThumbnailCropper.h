//
//  FaceThumbnailCropper.h
//  ReKo SDK
//
//  Created by Kuang Han on 10/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//
//  The helper class that crops face thumbnails from large images, merges thumbnails into a single compressed JPEG to be used by Rekognition API. The thumbnail size is highly optimized by including only the area sensitive to the backend algorithm.
//
//  After heard back from the server the result class need be passed to correctFaceDetectResult: to restore its coordinates to be relative the original image.


#import <Foundation/Foundation.h>
#import "ReKognitionResults.h"

@interface FaceThumbnailCropper : NSObject
- (UIImage *)cropFaceThumbnailsInUIImage:(UIImage *)uiImage;
- (UIImage *)cropFaceThumbnailsInNSData:(NSData *)imageData;
- (UIImage *)cropFaceThumbnailsInCIImage:(CIImage *)ciImage;

- (void)correctFaceDetectResult:(RKFaceDetectResults *)faceDetectResult;
@end
