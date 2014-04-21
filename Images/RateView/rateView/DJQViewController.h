//
//  DJQViewController.h
//  rateView
//
//  Created by 丁剑青 on 13-6-23.
//  Copyright (c) 2013年 丁剑青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
@interface DJQViewController : UIViewController
@property (weak, nonatomic) IBOutlet DJQRateView *rateView;
@property (weak, nonatomic) IBOutlet UISlider *rateValueSlider;
- (IBAction)rateValueChange:(id)sender;

@end
