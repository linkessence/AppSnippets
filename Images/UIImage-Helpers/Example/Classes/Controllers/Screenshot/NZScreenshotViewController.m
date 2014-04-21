//
//  NZScreenshotViewController.m
//  UIImage-Helpers
//
//  Created by Bruno Tortato Furtado on 21/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZScreenshotViewController.h"
#import "UIImage+Screenshot.h"

@interface NZScreenshotViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end



@implementation NZScreenshotViewController

#pragma mark -
#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage screenshot];
    self.imageView.image = image;
}

@end