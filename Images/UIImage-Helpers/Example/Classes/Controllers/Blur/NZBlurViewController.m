//
//  NZBlurViewController.m
//  UIImage-Helpers
//
//  Created by Bruno Tortato Furtado on 21/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZBlurViewController.h"
#import "UIImage+Blur.h"

@interface NZBlurViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageViewNormal;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewBlurred;

@end



@implementation NZBlurViewController

#pragma mark -
#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float quality = .00001f;
    float blurred = .5f;
    
    NSData *imageData = UIImageJPEGRepresentation([self.imageViewNormal image], quality);
    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
    self.imageViewBlurred.image = blurredImage;
}

@end