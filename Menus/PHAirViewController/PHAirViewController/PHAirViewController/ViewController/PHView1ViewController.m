//
//  PHView1ViewController.m
//  PHAirTransaction
//
//  Created by Ta Phuoc Hai on 1/14/14.
//  Copyright (c) 2014 Phuoc Hai. All rights reserved.
//

#import "PHView1ViewController.h"

@implementation PHView1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 35);
    [button setTitle:@"Menu" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    typeof(self) bself = self;
    self.phSwipeHander = ^{
        [bself.airViewController showAirViewFromViewController:bself.navigationController complete:nil];
    };
}

- (void)leftButtonTouch
{
    [self.airViewController showAirViewFromViewController:self.navigationController complete:nil];
}

@end
