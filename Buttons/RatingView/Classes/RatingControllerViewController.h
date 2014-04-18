//
//  RatingControllerViewController.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface RatingControllerViewController : UIViewController<RatingViewDelegate> {
	RatingView *starView;
	UILabel *ratingLabel;
}

@property (nonatomic, retain) IBOutlet RatingView *starView;
@property (nonatomic, retain) IBOutlet UILabel *ratingLabel;

-(IBAction)clearRating:(id)sender;
-(void)ratingChanged:(float)newRating;

@end

