//
//  DJQViewController.m
//  rateView
//
//  Created by 丁剑青 on 13-6-23.
//  Copyright (c) 2013年 丁剑青. All rights reserved.
//

#import "DJQViewController.h"

@interface DJQViewController ()

@end

@implementation DJQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rateView.rate = 3.8;
    self.rateValueSlider.value = 3.8;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)rateValueChange:(id)sender
{

    self.rateView.rate = self.rateValueSlider.value;
}

@end
