//
//  ViewController.m
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-18.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import "ViewController.h"
#import<CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "AttributedLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AttributedLabel *label = [[AttributedLabel alloc] initWithFrame:CGRectMake(20, 20, 150, 40)];
    
    
    // 注意！！一定要先给text赋值，然后再加属性；
    label.text = @"this is test";
    
    [self.view addSubview:label];
    
    // 设置this为红色
    [label setColor:[UIColor redColor] fromIndex:0 length:4];
    
    // 设置is为黄色
    [label setColor:[UIColor yellowColor] fromIndex:5 length:2];
    
    // 设置this字体为加粗16号字
    [label setFont:[UIFont boldSystemFontOfSize:30] fromIndex:0 length:4];
    
    // 给this加上下划线
    [label setStyle:kCTUnderlineStyleDouble fromIndex:0 length:4];
    
    label.backgroundColor = [UIColor clearColor];
    
    [label release];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [super dealloc];
}
@end
