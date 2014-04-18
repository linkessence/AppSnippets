//
//  ViewController.m
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-5.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"
#import <XHFaceMaskSDK/XHFaceDetection.h>

@interface ViewController ()

@property (nonatomic, strong) AVCaptureSession *sessoin;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *frameOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) UIView *preview;
@property (nonatomic, strong) XHFaceDetection *faceDetection;

@property (nonatomic) dispatch_queue_t liveImageProcQueue;

- (void)_start;

@end

@implementation ViewController



#pragma mark - Life cycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _preview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _preview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.preview];
    
    // setupFaceDetection
    _faceDetection = [[XHFaceDetection alloc] init];
    [_faceDetection _setupFaceDetection:self.preview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)_start {
    
    self.liveImageProcQueue = dispatch_queue_create("liveImageProcQueue", NULL);
    
    self.sessoin = [[AVCaptureSession alloc] init];
    self.sessoin.sessionPreset = AVCaptureSessionPreset352x288;
    
    
    // try to find the front facing camera
    __block AVCaptureDevice *selectedCaptureDevice = nil;
    
    [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        AVCaptureDevice *d = (AVCaptureDevice *)obj;
        if([d position] == AVCaptureDevicePositionFront){
            selectedCaptureDevice = d;
            *stop = YES;
        }
    }];
    
    // fallback to the default camera if no front facing camera was found
    if(!selectedCaptureDevice)
        selectedCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    self.videoDevice = selectedCaptureDevice;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:nil];
    
    self.frameOutput = [[AVCaptureVideoDataOutput alloc]init];
    self.frameOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [self.frameOutput setSampleBufferDelegate:self queue:self.liveImageProcQueue];
    
    [self.sessoin addInput:self.videoInput];
    [self.sessoin addOutput:self.frameOutput];
    
    
    AVCaptureVideoPreviewLayer* previewLayer = self.previewLayer;
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.sessoin];
	[previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
	CALayer *rootLayer = [self.preview layer];
    rootLayer.masksToBounds = YES;
    previewLayer.frame = rootLayer.bounds;
    previewLayer.bounds = previewLayer.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
	[rootLayer addSublayer:previewLayer];
    
    [_faceDetection _startRunning:self.videoDevice previewLayer:self.previewLayer];
    
    [self.sessoin startRunning];
}

- (void)dealloc
{
    [self.sessoin stopRunning];
    [self.sessoin removeInput:self.videoInput];
    [self.sessoin removeOutput:self.frameOutput];
    
    self.sessoin = nil;
    self.videoInput = nil;
    self.frameOutput = nil;
    
    self.videoDevice = nil;
    self.preview = nil;
    self.previewLayer = nil;
    self.faceDetection = nil;
    self.liveImageProcQueue = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    [_faceDetection didOutputSampleBuffer:sampleBuffer];
}


@end
