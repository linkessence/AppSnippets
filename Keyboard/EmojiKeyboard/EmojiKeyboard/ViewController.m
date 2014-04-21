//
//  ViewController.m
//  EmojiKeyboard
//
//  Created by wangjianle on 13-3-8.
//  Copyright (c) 2013年 wangjianle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   FaceToolBar* bar=[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight) superView:self.view];
    bar.delegate=self;
    [self.view addSubview:bar];
    [bar release];

	// Do any additional setup after loading the view, typically from a nib.
}
-(void)sendTextAction:(NSString *)inputText{
    NSLog(@"sendTextAction%@",inputText);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
