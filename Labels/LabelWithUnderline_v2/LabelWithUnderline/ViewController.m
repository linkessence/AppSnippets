//
//  ViewController.m
//  LabelWithUnderline
//
//  Created by WeiZhen_Liu on 13-5-1.
//  Copyright (c) 2013年 WeiZhen_Liu. All rights reserved.
//
#import "ViewController.h"
#import "UnderLineLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    NSString *str = @"Click me! so this is";
    
    UnderLineLabel *label = [[UnderLineLabel alloc] initWithFrame:CGRectMake(50, 200, 300, 30)];
    [label setBackgroundColor:[UIColor clearColor]];
    // [label setBackgroundColor:[UIColor yellowColor]];
    [label setTextColor:[UIColor blueColor]];
    [label setBackgroundColor:[UIColor yellowColor]];
    label.highlightedColor = [UIColor redColor];
    label.shouldUnderline = YES;
    
    
    [label setText:str andCenter:CGPointMake(200, 240)];
    [label addTarget:self action:@selector(labelClicked)];
    [self.view addSubview:label];
    [label release];


    
    UIImage *image = [UIImage imageNamed:@"ic_drop_down_arrow.png"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(labelClicked) forControlEvents:UIControlEventTouchUpInside];
    [button release];

    
    UnderLineLabel *label_2 = [[UnderLineLabel alloc] initWithFrame:CGRectMake(20, 300, 200, 30)];
    [label_2 setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:label_2];
    [label_2 setText:@"Test normal label" ];
    [label_2 release];
}

- (void)labelClicked
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Clicked!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
