//
//  IBPLightInfoViewController.m
//  IBPLight
//
//  Created by 朱克锋 on 13-2-17.
//  Copyright (c) 2013年 朱克锋. All rights reserved.
//

#import "IBPLightInfoViewController.h"

@interface IBPLightInfoViewController ()

@end

@implementation IBPLightInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ok:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
