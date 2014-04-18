//
//  IBPLightViewController.m
//  IBPLight
//
//  Created by 朱克锋 on 13-2-17.
//  Copyright (c) 2013年 朱克锋. All rights reserved.
//

#import "IBPLightViewController.h"
#import "IBPLightInfoViewController.h"

@interface IBPLightViewController ()
{
    NSTimer *timerFlash;
    bool enableFlash;
}

@property (nonatomic,retain) IBOutlet UIButton *btnOnOff;
@property (nonatomic,retain) IBOutlet UISwitch  *switchFlash;
@end

@implementation IBPLightViewController
@synthesize isLightOn;
@synthesize btnOnOff;
@synthesize switchFlash;

#define FREQ   2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isLightOn = YES;
    switchFlash.on = enableFlash;
    
    if (![self isDeviceHasTorch]) {
        [self showAlert];
        return;
    }

    [self turnOn:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.btnOnOff = nil;
    self.switchFlash = nil;
}

-(void)dealloc
{
    [self.btnOnOff release];
    [self.switchFlash release];
    [super dealloc];
}

#pragma mark button action
-(IBAction)infoBtn:(id)sender
{
    IBPLightInfoViewController *vc = [[IBPLightInfoViewController alloc] initWithNibName:@"IBPLightInfoViewController" bundle:nil];
    [self presentModalViewController:vc animated:YES];
    [vc release];
}

-(IBAction)onBtnOnOff:(id)sender
{
    if (isFlashOn) {
        [self onBtnFlash];
    }
    else
    {
        isLightOn = 1 - isLightOn;
        if (isLightOn) {
            [self turnOn:YES];
        }
        else
        {
            [self turnOff:YES];
        }
    }
}

-(IBAction)onSwitch:(id)sender
{
    UISwitch *uiSwitch = (UISwitch *)sender;
    
    enableFlash = uiSwitch.on;
    
    if (!enableFlash) {
        [self switchOff:sender];
    }
    else
    {
        [self switchOn:sender];
    }
    
    [self ledFlash];
}

-(BOOL)isDeviceHasTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {        
        return NO;
    }
    return YES;
}

-(void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"抱歉，该设备没有闪光灯而无法使用手电筒功能！" delegate:nil
                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

-(void) turnOn:(bool)update
{
    [self torchOn:YES];
    if (update) {
        [self btnImageName:@"powerbuttonon.png"];
    }
}

-(void)torchOn:(BOOL)on
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (on) {
            [device setTorchMode: AVCaptureTorchModeOn];
        }
        else
        {
            [device setTorchMode: AVCaptureTorchModeOff];
        }
        
        [device unlockForConfiguration];
    }
}

-(void)btnImageName:(NSString*)imgName
{
    [btnOnOff setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

-(void) turnOff:(bool)update
{
    [self torchOn:NO];
    if (update) {
        [self btnImageName:@"powerbuttonoff.png"];
    }
}

-(void)switchOff:(id)sender
{
    if (sender) {
        if (isLightOn) {
            [self turnOn:YES];
        }
        else
        {
            [self turnOff:YES];
        }
        isFlashOn = NO;
    }
    else
    {
        isLightOn = NO;
        [self turnOff:YES];
        [self btnImageName:@"powerbuttonoff.png"];
    }
}

-(void)switchOn:(id)sender
{
    if (sender) {
        isFlashOn = YES;
    }
    else
    {
        [self btnImageName:@"powerbuttonon.png"];
    }
    isLightOn = YES;
    [self turnOn:YES];
}

-(void)onBtnFlash
{
    enableFlash = 1-enableFlash;
    if (!enableFlash) {
        isLightOn = NO;
        [self turnOff:YES];
        [self btnImageName:@"powerbuttonoff.png"];
        switchFlash.on = enableFlash;
    }
    else
    {
        [self btnImageName:@"powerbuttonon.png"];
        switchFlash.on = enableFlash;
        isLightOn = YES;
        [self turnOn:YES];
    }

    [self ledFlash];
}

- (void) ledFlash
{
    double time = 1.0/FREQ;
    
    if (!enableFlash) {
        return;
    }
    
    if (timerFlash) {
        [timerFlash invalidate];
        timerFlash = nil;
    }
    timerFlash= [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(onTimerFlash) userInfo:nil repeats:YES];
}

-(void) onTimerFlash
{
    static int count=0;
    
    if (!enableFlash) {
        return;
    }
    
    if (count%2) {
        [self turnOn:NO];
    }
    else
    {
        [self turnOff:NO];
    }
    count ++;    
}
@end
