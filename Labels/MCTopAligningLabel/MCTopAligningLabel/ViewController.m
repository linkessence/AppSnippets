//
//  ViewController.m
//  MCTopAligningLabel
//
//  Created by Baglan on 11/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mclabel = [[MCTopAligningLabel alloc] initWithFrame:CGRectMake(5, 20, 200, 150)];
    [self.mclabel setText:@"MCTopAligningLabel"];
    [self.view addSubview:self.mclabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(220, 20, 70, 150)];
    label.text = @"UILabel";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
