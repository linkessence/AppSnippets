//
//  TestViewController.m
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import "TestViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation TestViewController

@synthesize AVSession;

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (void)toggleFlashlight
{
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

  if (device.torchMode == AVCaptureTorchModeOff) 
  {
    // Create an AV session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];

    // Create device input and add to current session
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
    [session addInput:input];

    // Create video output and add to current session      
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];

    // Start session configuration
    [session beginConfiguration];
    [device lockForConfiguration:nil];

		// Set torch to on
    [device setTorchMode:AVCaptureTorchModeOn];

    [device unlockForConfiguration];
    [session commitConfiguration];

    // Start the session
    [session startRunning];

		// Keep the session around
    [self setAVSession:session];
    
    [output release];
  }
  else 
  {
    [AVSession stopRunning];
    [AVSession release], AVSession = nil;
  }
}    

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (void)loadView 
{
  [self setView:[[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease]];

	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

	// If torch supported, add button to toggle flashlight on/off
	if ([device hasTorch] == YES)
	{
    flashlightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 320, 98)];
	  [flashlightButton setBackgroundImage:[UIImage imageNamed:@"TorchOn.png"] forState:UIControlStateNormal];
	  [flashlightButton addTarget:self action:@selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];      

	  [[self view] addSubview:flashlightButton];
	}
  
}

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (void)buttonPressed:(UIButton *)button
{
  if (button == flashlightButton)
  {
  	if (flashlightOn == NO)
    {
    	flashlightOn = YES;
      [flashlightButton setBackgroundImage:[UIImage imageNamed:@"TorchOff.png"] forState:UIControlStateNormal];
	  
    }
    else 
    {    	
    	flashlightOn = NO;
		  [flashlightButton setBackgroundImage:[UIImage imageNamed:@"TorchOn.png"] forState:UIControlStateNormal];    
    }

		[self toggleFlashlight];

  }
}

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (void)dealloc 
{
	[flashlightButton release];
	if (AVSession != nil)
  	[AVSession release];
        
	[super dealloc];
}

@end
