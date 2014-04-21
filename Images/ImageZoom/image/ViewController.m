//
//  ViewController.m
//  image
//
//  Created by itensen001 on 13-3-21.
//  Copyright (c) 2013年 czj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [self scaleFromImage:[UIImage imageNamed:@"5.png"] toSize:CGSizeMake(286, 236)];
    _maskView.image = image;
//    _maskView.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)dealloc {
    [_maskView release];
    [super dealloc];
}

@end
