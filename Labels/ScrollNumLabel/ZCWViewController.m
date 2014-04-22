//
//  ZCWViewController.m
//  ScrollNumLabel
//
//  Created by zangcw on 12-9-7.
//  Copyright (c) 2012年 zangcw. All rights reserved.
//

#import "ZCWViewController.h"
#import "ZCWScrollNumView.h"

#define kAllFullSuperviewMask      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
@interface ZCWViewController ()

@end

@implementation ZCWViewController
@synthesize scrollNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGRect tmp = {{0, 0}, {100, 100}};
    self.scrollNumber.numberSize = 8;
    UIImage *image = [[UIImage imageNamed:@"bj_numbg"] stretchableImageWithLeftCapWidth:10 topCapHeight:14];
    self.scrollNumber.backgroundView = [[[UIImageView alloc] initWithImage:image] autorelease];
    UIView *digitBackView = [[[UIView alloc] initWithFrame:tmp] autorelease];
    digitBackView.backgroundColor = [UIColor clearColor];
    digitBackView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    digitBackView.autoresizesSubviews = YES;
    image = [[UIImage imageNamed:@"money_bg"] stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImageView *bgImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    bgImageView.frame = tmp;
    bgImageView.autoresizingMask = kAllFullSuperviewMask;
    [digitBackView addSubview:bgImageView];
    image = [[UIImage imageNamed:@"money_bg_mask"] stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImageView *bgMaskImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    bgMaskImageView.autoresizingMask = kAllFullSuperviewMask;
    bgMaskImageView.frame = tmp;
    [digitBackView addSubview:bgMaskImageView];
    
    self.scrollNumber.digitBackgroundView = digitBackView;
    self.scrollNumber.digitColor = [UIColor whiteColor];
    self.scrollNumber.digitFont = [UIFont systemFontOfSize:17.0];
    [self.scrollNumber didConfigFinish];
}

- (void)viewDidUnload
{
    [self setScrollNumber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)none:(id)sender {
    [self.scrollNumber setNumber:rand() withAnimationType:ZCWScrollNumAnimationTypeNone animationTime:0.1];
}

- (IBAction)fromZero:(id)sender {
    [self.scrollNumber setNumber:rand() withAnimationType:ZCWScrollNumAnimationTypeNormal animationTime:0.3];
}

- (IBAction)fromLast:(id)sender {
    [self.scrollNumber setNumber:rand() withAnimationType:ZCWScrollNumAnimationTypeFromLast animationTime:0.3];
}

- (IBAction)fast:(id)sender {
    [self.scrollNumber setNumber:rand() withAnimationType:ZCWScrollNumAnimationTypeFast animationTime:0.1];
}

- (IBAction)random:(id)sender {
    [self.scrollNumber setNumber:rand() withAnimationType:ZCWScrollNumAnimationTypeRand animationTime:3];
}
- (void)dealloc {
    [scrollNumber release];
    [super dealloc];
}
@end
