//
//  ViewController.m
//  XHFaceRecognizerSDKSimple
//
//  Created by 曾 宪华 on 13-12-26.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.simpleImageView = [[XHFaceRecognizerView alloc] initWithFrame:CGRectMake(0, 64, 320, 320)];
    [self.view addSubview:self.simpleImageView];
    
    [self reset:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.simpleImageView = nil;
}

- (IBAction)recognizer:(id)sender {
    [self.simpleImageView startFaceRecognizer];
}

- (IBAction)reset:(id)sender {
    [self.simpleImageView resetNormalImage:[UIImage imageNamed:@"steves.jpg"]];
}

- (IBAction)cropped:(id)sender {
    [self.simpleImageView croppingFaceWtihFaceCropCompelted:^(NSArray *croppedImages, NSError *error) {
        NSLog(@"croppedImages : %@", croppedImages);
    }];
}

@end
