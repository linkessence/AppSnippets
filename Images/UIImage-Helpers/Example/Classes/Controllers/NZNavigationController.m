//
//  NZNavigationController.m
//  UIImage-Helpers
//
//  Created by Bruno Tortato Furtado on 21/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZNavigationController.h"
#import "UIImage+ImageWithColor.h"

@interface NZNavigationController ()

@end



@implementation NZNavigationController

#pragma mark -
#pragma mark - UINavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *purpleColor = [UIColor colorWithRed:.927f green:.264f blue:.03f alpha:1];
    UIImage *image = [UIImage imageWithColor:purpleColor];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end