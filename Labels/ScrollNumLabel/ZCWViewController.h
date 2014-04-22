//
//  ZCWViewController.h
//  ScrollNumLabel
//
//  Created by zangcw on 12-9-7.
//  Copyright (c) 2012年 zangcw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCWScrollNumView;
@interface ZCWViewController : UIViewController

@property (retain, nonatomic) IBOutlet ZCWScrollNumView *scrollNumber;

- (IBAction)none:(id)sender;
- (IBAction)fromZero:(id)sender;
- (IBAction)fromLast:(id)sender;
- (IBAction)fast:(id)sender;
- (IBAction)random:(id)sender;



@end
