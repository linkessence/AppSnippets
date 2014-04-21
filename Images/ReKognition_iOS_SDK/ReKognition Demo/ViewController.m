//
//  ViewController.m
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/18/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import "ViewController.h"
#import "FaceThumbnailCropper.h"
#import "ReKognitionSDK.h"
#import "ReKognitionResults.h"
#import <QuartzCore/QuartzCore.h>
#import "FaceThumbnailCropper.h"
#import "UIImageRotationFixer.h"
#import "APIKey+Secret.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ReKognition Example";
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    labelView.hidden = YES;
    activityIndicator.hidesWhenStopped = YES;
	// Do any additional setup after loading the view, typically from a nib.
    // Base64 encode your jpeg image
}


- (IBAction)btnReKognizeImageClicked:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose the following..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Face Detection", @"Scene Understanding", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	actionSheet.alpha = 0.80;
	actionSheet.tag = 2;
	[actionSheet showInView:self.view];
}

- (IBAction)btnSelectImageClicked:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallary", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	actionSheet.alpha = 0.80;
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (actionSheet.tag)
	{
		case 1:
			switch (buttonIndex)
        {
                labelView.hidden = YES;
            case 0:
            {
#if TARGET_IPHONE_SIMULATOR
				
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Saw Them" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
				
#elif TARGET_OS_IPHONE
				
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                //picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
                [self clearRecognitionResults];
#endif
            }
                break;
            case 1:
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
                [self clearRecognitionResults];
            }
                break;
        }
			break;
            
        case 2:
            switch (buttonIndex)
        {
            case 0:
            {
                if(imageView.image){
                    
                    // image x, y, width, height
                    float image_x, image_y, image_width, image_height;
                    if(imageView.image.size.width/imageView.image.size.height > imageView.frame.size.width/imageView.frame.size.height){
                        image_width = imageView.frame.size.width;
                        image_height = image_width/imageView.image.size.width * imageView.image.size.height;
                        image_x = 0;
                        image_y = (imageView.frame.size.height - image_height)/2;
                        
                        
                        if (imageView.image.size.width > 2600){
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Image too large" message:@"Max image size is 3000 px" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            break;
                        }
                    }else if(imageView.image.size.width/imageView.image.size.height < imageView.frame.size.width/imageView.frame.size.height)
                    {
                        image_height = imageView.frame.size.height;
                        image_width = image_height/imageView.image.size.height * imageView.image.size.width;
                        image_y = 0;
                        image_x = (imageView.frame.size.width - image_width)/2;
                        if (imageView.image.size.width > 2600){
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Image too large" message:@"Max image size is 3000 px" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            break;
                        }
                        
                    }else{
                        image_x = 0;
                        image_y = 0;
                        image_width = imageView.frame.size.width;
                        image_height = imageView.frame.size.height;
                        if (imageView.image.size.width > 2600){
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Image too large" message:@"Max image size is 3000 px" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            break;
                        }
                    }
                    
                    
                    [activityIndicator startAnimating];
                    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
                    dispatch_async(queue, ^{
                        
                        FaceThumbnailCropper *cropper = [[FaceThumbnailCropper alloc] init];
                        UIImage *cropped = [cropper cropFaceThumbnailsInUIImage:imageView.image];
                        RKFaceDetectResults* detectResults;
                        ReKognitionSDK *sdk = [[ReKognitionSDK alloc] initWithAPIKey:API_KEY APISecret:API_SECRET];
                        if (cropped) {
                            detectResults = [sdk RKFaceDetect:cropped jobs:FaceDetectAge|FaceDetectEyeClosed|FaceDetectPart|FaceDetectGender|FaceDetectGlass];
                            [cropper correctFaceDetectResult:detectResults];
                        } else {
                            detectResults = [sdk RKFaceDetect:imageView.image jobs:FaceDetectAge|FaceDetectEyeClosed|FaceDetectPart|FaceDetectGender|FaceDetectGlass];
                        }
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [activityIndicator stopAnimating];
                            labelView.hidden = NO;
                            
                            NSArray * list = detectResults.faceDetectOrALikeItems;
                            labelView.text = @"Face detection: \n";
                            
                            int face_no = 0;
                            for(int i = 0; i < [list count]; i++){
                                FaceDetectItem *item = list[i];
                                if (item.confidence > 0.1){
                                    
                                    face_no = face_no + 1;
                                    
                                    float gender = item.sex;
                                    float glasses = item.wear_glasses;
                                    float confidence = item.confidence;
                                    float eye_closed = item.eye_closed;
                                    float age = item.age;
                                    
                                    
                                    labelView.text = [labelView.text stringByAppendingFormat:@"Face %d -- ", i+1];
                                    labelView.text = [labelView.text stringByAppendingFormat:@"confidence: %04.2f; ",
                                                      confidence];
                                    labelView.text = [labelView.text stringByAppendingFormat:@"glass: %04.2f; ",
                                                      glasses];
                                    labelView.text = [labelView.text stringByAppendingFormat:@"age: %04.2f; ",
                                                      age];
                                    labelView.text = [labelView.text stringByAppendingFormat:@"eye_closed: %04.2f.\n",
                                                      eye_closed];
                                    
                                    
                                    //for debug
                                    //NSLog(@"%f, %f, %f, %f", image_x, image_y, image_width, image_height);
                                    //NSLog(@"%f, %f, %f, %f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
                                    //NSLog(@"%f, %f", imageView.image.size.width, imageView.image.size.height);
                                    //NSLog(@"%f", scale);
                                    
                                    CGFloat resize_scale = image_width/imageView.image.size.width;
                                    //NSLog(@"%f", resize_scale);
                                    
                                    // drawing faces
                                    
                                    // returned bounding box
                                    float x = item.boundingbox.origin.x;
                                    float y = item.boundingbox.origin.y;
                                    float width = item.boundingbox.size.width;
                                    float height = item.boundingbox.size.height;
                                    
                                    CALayer *layer = [CALayer new];
                                    layer.borderWidth = 2.0f;
                                    [layer setCornerRadius:5.0f*resize_scale];
                                    [layer setFrame:CGRectMake(x*resize_scale + image_x,
                                                               y*resize_scale + image_y,
                                                               width*resize_scale,
                                                               height*resize_scale)];
                                    layer.borderColor = [[UIColor colorWithRed:(1-gender) green:0.0 blue:gender alpha:1] CGColor];
                                    
                                    // returned right eye position
                                    float radius = width*resize_scale/40;
                                    float eye_right_x = item.eye_right.x;
                                    float eye_right_y = item.eye_right.y;
                                    CALayer *eye_right_layer = [CALayer new];
                                    [eye_right_layer setCornerRadius:radius];
                                    eye_right_layer.backgroundColor = layer.borderColor;
                                    [eye_right_layer setFrame:CGRectMake((eye_right_x - x)*resize_scale - radius,
                                                                         (eye_right_y - y)*resize_scale - radius,
                                                                         radius * 2, radius * 2)];
                                    
                                    // returned left eye position
                                    float eye_left_x = item.eye_left.x;
                                    float eye_left_y = item.eye_left.y;
                                    CALayer *eye_left_layer = [CALayer new];
                                    eye_left_layer.backgroundColor = layer.borderColor;
                                    [eye_left_layer setCornerRadius:radius];
                                    [eye_left_layer setFrame:CGRectMake((eye_left_x - x)*resize_scale - radius,
                                                                        (eye_left_y - y)*resize_scale - radius,
                                                                        radius * 2, radius * 2)];
                                    
                                    // returned nose position
                                    float nose_x = item.nose.x;
                                    float nose_y = item.nose.y;
                                    CALayer *nose_layer = [CALayer new];
                                    nose_layer.backgroundColor = layer.borderColor;
                                    [nose_layer setCornerRadius: radius];
                                    [nose_layer setFrame:CGRectMake((nose_x - x)*resize_scale - radius,
                                                                    (nose_y - y)*resize_scale - radius,
                                                                    radius * 2,
                                                                    radius * 2)];
                                    
                                    // returned right mouth position
                                    float mouth_right_x = item.mouth_r.x;
                                    float mouth_right_y = item.mouth_r.y;
                                    CALayer *mouth_right_layer = [CALayer new];
                                    mouth_right_layer.backgroundColor = layer.borderColor;
                                    [mouth_right_layer setCornerRadius: radius];
                                    [mouth_right_layer setFrame:CGRectMake((mouth_right_x - x)*resize_scale - radius,
                                                                           (mouth_right_y - y)*resize_scale - radius,
                                                                           radius * 2,
                                                                           radius * 2)];
                                    
                                    
                                    // returned left mouth position
                                    float mounth_left_x = item.mouth_l.x;
                                    float mounth_left_y = item.mouth_l.y;
                                    CALayer *mouth_left_layer = [CALayer new];
                                    mouth_left_layer.backgroundColor = layer.borderColor;
                                    [mouth_left_layer setCornerRadius:radius];
                                    [mouth_left_layer setFrame:CGRectMake((mounth_left_x - x)*resize_scale - radius,
                                                                          (mounth_left_y - y)*resize_scale - radius,
                                                                          radius * 2,
                                                                          radius * 2)];
                                    
                                    
                                    
                                    
                                    CATextLayer *label = [[CATextLayer alloc] init];
                                    [label setFontSize:16];
                                    [label setString:[@"" stringByAppendingFormat:@"%d", i+1]];
                                    [label setAlignmentMode:kCAAlignmentCenter];
                                    [label setForegroundColor:layer.borderColor];
                                    [label setFrame:CGRectMake(0, layer.bounds.size.height, layer.frame.size.width, 25)];
                                    
                                    
                                    [layer addSublayer:eye_left_layer];
                                    [layer addSublayer:eye_right_layer];
                                    [layer addSublayer:nose_layer];
                                    [layer addSublayer:mouth_left_layer];
                                    [layer addSublayer:mouth_right_layer];
                                    [layer addSublayer:label];
                                    
                                    [imageView.layer addSublayer:layer];
                                }
                                
                            }
                            
                            if(face_no > 2){
                                labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height + 45 * (face_no-2));
                                labelView.numberOfLines = 1 + face_no * 2;
                            }
                        });
                    });
                    
                }else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Image" message:@"Select an image first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
                break;
            case 1:
            {
                if(imageView.image){
                    CGFloat scale = 1;
                    if(imageView.image.size.width > 640){
                        scale = 640/imageView.image.size.width;
                    }
                    [activityIndicator startAnimating];
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
                    dispatch_async(queue, ^{
                        ReKognitionSDK *sdk = [[ReKognitionSDK alloc] initWithAPIKey:API_KEY APISecret:API_SECRET];
                        RKSceneUnderstandingResults *sceneResults = [sdk RKSceneUnderstanding:imageView.image];
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [activityIndicator stopAnimating];
                            
                            labelView.hidden = NO;
                            labelView.text = @" Scene understanding:\n";
                            
                            NSArray *scenes = sceneResults.matched_scenes;
                            NSArray *scores = sceneResults.matched_scene_scores;
                            for(int i = 0; i < [scenes count]; i++){
                                labelView.text = [labelView.text stringByAppendingFormat:@"    %@: %@\n",
                                                  scenes[i],
                                                  scores[i]];
                            }
                            NSLog(@"%d", [scenes count]);
                        });
                    });
                    
                }else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Image" message:@"Select an image first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
                break;
        }
			break;
			
		default:
			break;
            
	}
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    
    UIImage *rawImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageView.image = [UIImageRotationFixer fixOrientation:rawImage];
    NSLog(@"%d", imageView.image.imageOrientation);
    NSLog(@"%f %f", imageView.image.size.width, imageView.image.size.height);
    
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) clearRecognitionResults{
    labelView.hidden = YES;
    if(imageView.layer.sublayers)
        [imageView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height + 78);
    
}


@end


