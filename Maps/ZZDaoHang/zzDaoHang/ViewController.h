//
//  ViewController.h
//  zzDaoHang
//
//  Created by zzzili on 13-12-14.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *web;
- (IBAction)ZiJia:(id)sender;
- (IBAction)TuBu:(id)sender;
- (IBAction)Gongjia:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *text;
@property (retain, nonatomic) IBOutlet UILabel *text2;

@end
