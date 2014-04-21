//
//  _6000ViewController.m
//  36000
//
//  Created by iMac on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "_6000ViewController.h"
@implementation _6000ViewController
@synthesize plView;

- (void)dealloc
{
    [plView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    plView.isDeviceOrientationEnabled = NO;
	plView.isAccelerometerEnabled = NO;
	plView.isScrollingEnabled = NO;
	plView.isInertiaEnabled = NO;
	plView.type = PLViewTypeSpherical;
	[plView addTexture:[PLTexture textureWithPath:[[NSBundle mainBundle] pathForResource:@"pano" ofType:@"jpg"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft ||interfaceOrientation==UIInterfaceOrientationLandscapeRight);
}

@end
