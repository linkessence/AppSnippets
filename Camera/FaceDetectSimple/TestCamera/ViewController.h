//
//  ViewController.h
//  TestCamera
//
//  Created by zzzili on 13-9-24.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+fixOrientation.h"
#import <CoreImage/CoreImage.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import "GPUImage.h"

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDeviceInput *_captureInput;
    AVCaptureStillImageOutput *_captureOutput;
    AVCaptureVideoPreviewLayer *_preview;
    AVCaptureDevice *_device;
    
    UIView* m_highlitView[100];
    CGAffineTransform m_transform[100];
}
@property (retain, nonatomic) IBOutlet UIView *cameraView;
@property (retain, nonatomic) IBOutlet UIImageView *smalImage;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) CALayer *customLayer;
- (IBAction)turnCamera:(id)sender;

@end
