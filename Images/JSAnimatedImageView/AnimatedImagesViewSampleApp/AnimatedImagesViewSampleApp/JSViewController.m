//
//  JSViewController.m
//  AnimatedImagesViewSampleApp
//
//  Created by Javier Soto on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface JSViewController()
@property (retain, nonatomic) IBOutlet JSAnimatedImagesView *animatedImagesView;
@property (retain, nonatomic) IBOutlet UIView *infoBox;
@end

@implementation JSViewController

@synthesize infoBox = _infoBox;
@synthesize animatedImagesView = _animatedImagesView;

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animatedImagesView.delegate = self;
    
    self.infoBox.layer.cornerRadius = 6;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.animatedImagesView startAnimating];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.animatedImagesView stopAnimating];
}

#pragma mark - JSAnimatedImagesViewDelegate Methods

- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return 3;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", index + 1]];
}

#pragma mark - UI

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Memory Management

- (void)viewDidUnload
{    
    [self setAnimatedImagesView:nil];    
    [self setInfoBox:nil];
    
    [super viewDidUnload];    
}

- (void)dealloc
{    
    [_animatedImagesView release];    
    [_infoBox release];
    
    [super dealloc];
}

@end