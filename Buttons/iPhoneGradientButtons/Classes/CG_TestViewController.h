//
//  CG_TestViewController.h
//  CG Test
//
//  Created by jeff on 5/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientButton.h"
@interface CG_TestViewController : UIViewController 
{

    GradientButton    *blackButton;
    GradientButton    *whiteButton;
    GradientButton    *alertButton;
    GradientButton    *orangeButton;
    GradientButton    *redButton;
    GradientButton    *greenButton;
    GradientButton    *blackActionButton;
    GradientButton    *whiteActionButton;
}
@property (nonatomic, retain) IBOutlet  GradientButton *blackButton;
@property (nonatomic, retain) IBOutlet  GradientButton *whiteButton;
@property (nonatomic, retain) IBOutlet  GradientButton *alertButton;
@property (nonatomic, retain) IBOutlet  GradientButton *orangeButton;
@property (nonatomic, retain) IBOutlet  GradientButton *redButton;
@property (nonatomic, retain) IBOutlet  GradientButton *greenButton;
@property (nonatomic, retain) IBOutlet  GradientButton *blackActionButton;
@property (nonatomic, retain) IBOutlet  GradientButton *whiteActionButton;
@end

