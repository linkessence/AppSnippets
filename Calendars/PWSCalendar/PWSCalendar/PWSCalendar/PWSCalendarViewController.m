//
//  PWSCalendarViewController.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "PWSCalendarViewController.h"
#import "PWSDefaultViewController.h"
#import "PWSCustomViewController.h"
/////////////////////////////////////////////////////////////////////
@interface PWSCalendarViewController ()
{
    
}
@end
/////////////////////////////////////////////////////////////////////
@implementation PWSCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self SetInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) SetInit
{
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton* b1 = [PWSCalendarViewController GetButtonWithTitle:@"default"];
    [b1 setFrame:CGRectMake(100, 50, 100, 50)];
    [b1 addTarget:self action:@selector(BtnToDefault) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b1];
    
    UIButton* b2 = [PWSCalendarViewController GetButtonWithTitle:@"custom"];
    [b2 setFrame:CGRectMake(100, 150, 100, 50)];
    [b2 addTarget:self action:@selector(BtnToCustom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b2];
}

- (void) BtnToDefault
{
    PWSDefaultViewController* dd = [[PWSDefaultViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:dd animated:YES];
}

- (void) BtnToCustom
{
    PWSCustomViewController* pp = [[PWSCustomViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:pp animated:YES];
}


+ (UIButton*) GetButtonWithTitle:(NSString*)_pTitle
{
    UIButton* rt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rt setTitle:_pTitle forState:UIControlStateNormal];
    [rt.layer setBorderColor:[UIColor blueColor].CGColor];
    [rt.layer setBorderWidth:2];
    [rt.layer setCornerRadius:10];
    [rt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rt setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    return rt;
}

@end
