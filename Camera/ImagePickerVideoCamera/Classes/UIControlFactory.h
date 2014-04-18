//
//  UIControlFactory.h
//  GaoHong
//
//  Created by Lin Charlie C. on 11-2-18.
//  Copyright 2011  高鸿移通. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIControlFactory : NSObject {

}
+ (UIButton *)buttonWithTitle:	(NSString *)title
					   target:(id)target
					 selector:(SEL)selector
						frame:(CGRect)frame
						image:(UIImage *)image
				 imagePressed:(UIImage *)imagePressed
				darkTextColor:(BOOL)darkTextColor;

+(UITextField*)textFieldWithFrame:(CGRect)frame;
+(UIAlertView*) alertActionAutoRelease:(NSString*)title message:(NSString*)msg;
+(UIAlertView*) alertAction:(NSString*)title message:(NSString*)msg;
+(UIAlertView*) alertActionAgree:(NSString*)title message:(NSString*)msg;
+(UIActionSheet*)dialogAction:(NSString*)title delegate:(id)target;
+(UIView*)waitAction:(NSString*)title background:(UIColor*)color;
+(UIView*)heightwaitAction:(NSString*)title background:(UIColor*)color;
@end
