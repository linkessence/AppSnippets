//
//  ViewController.m
//  ZenKeyboardDemo
//
//  Created by Mac on 13-7-8.
//  Copyright (c) 2013年 iiii1314iiii@qq.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize keyboardView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    keyboardView = [[ZenKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    [self.ZenKeyTexField setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    
    keyboardView.textField = self.ZenKeyTexField;
    keyboardView.VoiceSwitch=self.VoiceSwitch;
    [self.view addSubview:self.ZenKeyTexField];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
