//
//  ViewController.m
//  TestCamera
//
//  Created by zzzili on 13-9-24.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    //[self detectForFacesInUIImage:[UIImage imageNamed:@"111.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_cameraView release];
    [_imageView release];
    [_customLayer release];
    [_smalImage release];
    [super dealloc];
}

//初始化
- (void) initialize
{
    //1.创建会话层
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPreset640x480];
    
    //2.创建、配置输入设备
	
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
           _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    NSError *error;
	if (!_captureInput)
	{
		NSLog(@"Error: %@", error);
		return;
	}
    [_session addInput:_captureInput];
    
    ///out put
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc]
                                               init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    //captureOutput.minFrameDuration = CMTimeMake(1, 10);
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    dispatch_release(queue);
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber
                       numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary
                                   dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [_session addOutput:captureOutput];
    
    ///custom Layer
    self.customLayer = [CALayer layer];
    self.customLayer.frame = self.view.bounds;
    self.customLayer.transform = CATransform3DRotate(
                                                     CATransform3DIdentity, M_PI/2.0f, 0, 0, 1);
    self.customLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:self.customLayer];
    
    //3.创建、配置输出
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_captureOutput setOutputSettings:outputSettings];
	[_session addOutput:_captureOutput];
    
    ////////////
    _preview = [AVCaptureVideoPreviewLayer layerWithSession: _session];
    _preview.frame = CGRectMake(0, 0, self.cameraView.frame.size.width, self.cameraView.frame.size.height);
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.cameraView.layer addSublayer:_preview];
    [_session startRunning];
    
   // NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
   

}

//从摄像头缓冲区获取图像
#pragma mark -
#pragma mark AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                    width, height, 8, bytesPerRow, colorSpace,
                                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    
    
    UIImage *image= [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationLeftMirrored];
    
    CGImageRelease(newImage);
    
    image = [image fixOrientation];//图像反转
    
    
    [self performSelectorOnMainThread:@selector(detectForFacesInUIImage:)
                           withObject: (id) image waitUntilDone:NO];
    
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    [pool drain];
    
    
}

/////人脸识别
-(void)detectForFacesInUIImage:(UIImage *)facePicture
{
    CIImage* image = [CIImage imageWithCGImage:facePicture.CGImage];
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyLow forKey:CIDetectorAccuracy]];
    
    NSArray* features = [detector featuresInImage:image];
//    NSLog(@"%f---%f",facePicture.size.width,facePicture.size.height);
    for(int j=0;m_highlitView[j]!=nil;j++)
    {
        m_highlitView[j].hidden = YES;
    }
    int i=0;
    for(CIFaceFeature* faceObject in features)
    {
        NSLog(@"found face");
        CGRect modifiedFaceBounds = faceObject.bounds;
        modifiedFaceBounds.origin.y = facePicture.size.height-faceObject.bounds.size.height-faceObject.bounds.origin.y;
        
        [self addSubViewWithFrame:modifiedFaceBounds index:i];
        i++;
    }
    [facePicture release];
}

///自画图像
-(void)addSubViewWithFrame:(CGRect)frame  index:(int)_index
{
    if(m_highlitView[_index]==nil)
    {
        m_highlitView[_index]= [[UIView alloc] initWithFrame:frame];
        m_highlitView[_index].layer.borderWidth = 2;
        m_highlitView[_index].layer.borderColor = [[UIColor redColor] CGColor];
        [self.imageView addSubview:m_highlitView[_index]];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"found face!!!!!!";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(0, 0, frame.size.width, 20);
        [m_highlitView[_index] addSubview:label];
        [label release];
        
        UIImageView *bqImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bq.png"]];
        bqImage.frame = CGRectMake(0, -30, 30, 30);
        [m_highlitView[_index] addSubview:bqImage];
        [bqImage release];
        
        m_transform[_index] = m_highlitView[_index].transform;
    }
    frame.origin.x = frame.origin.x/1.5;
    frame.origin.y = frame.origin.y/1.5;
    frame.size.width = frame.size.width/1.5;
    frame.size.height = frame.size.height/1.5;
    m_highlitView[_index].frame = frame;
    
    ///根据头像大小缩放自画View
    float scale = frame.size.width/220;
    CGAffineTransform transform = CGAffineTransformScale(m_transform[_index], scale,scale);
    m_highlitView[_index].transform = transform;
    
    m_highlitView[_index].hidden = NO;
}
////////////////////////////////////////摄像头反转
- (IBAction)turnCamera:(id)sender {
    
    NSArray *inputs = _session.inputs;
    for ( AVCaptureDeviceInput *input in inputs )
    {
        AVCaptureDevice *device = input.device;
        if ([device hasMediaType:AVMediaTypeVideo])
        {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
            {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            }
            else
            {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            }
            _device = newCamera;
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [_session beginConfiguration];
            
            [_session removeInput:input];
            [_session addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [_session commitConfiguration];
            break;
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

@end
