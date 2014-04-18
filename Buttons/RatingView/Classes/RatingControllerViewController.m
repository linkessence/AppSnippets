//
//  RatingControllerViewController.m
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RatingControllerViewController.h"

@implementation RatingControllerViewController

@synthesize starView;
@synthesize ratingLabel;

- (void)dealloc {
	[starView release];
	[ratingLabel release];
    [super dealloc];
}

-(void)ratingChanged:(float)newRating {
	ratingLabel.text = [NSString stringWithFormat:@"Rating is: %1.1f", newRating];
}

-(IBAction)clearRating:(id)sender {
	[starView displayRating:0.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"Initializing rating view");
	[starView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:self];
	[starView displayRating:1.5];
}

@end
