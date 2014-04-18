//
//  UIControlFactory.m
//  GaoHong
//
//  Created by Lin Charlie C. on 11-2-18.
//  Copyright 2011  高鸿移通. All rights reserved.
//

#import "UIControlFactory.h"
//@interface UINavigationBar (CustomImage)
//- (void) drawRect: (CGRect)rect;
//@end
//@implementation UINavigationBar (CustomImage)
//- (void) drawRect: (CGRect)rect
//{
//	UIImage *image = [UIImage imageNamed: @"title_bg.png"];   
//	[image drawInRect:CGRectMake(0, 0, self.frame.size.width+5, self.frame.size.height+5)];
//}
//@end
@interface UITabBar (CustomImage)
- (void)drawRect:(CGRect)rect;
@end
@implementation UITabBar (CustomImage)
- (void)drawRect:(CGRect)rect{
	// Drawing code.
	CGRect bounds=[self bounds];
	[[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bkg.png"]] set];
	UIRectFill(bounds);
}
@end

@implementation UIControlFactory
+ (UIButton *)buttonWithTitle:(NSString *)title
					   target:(id)target
					 selector:(SEL)selector
						frame:(CGRect)frame
						image:(UIImage *)image
				 imagePressed:(UIImage *)imagePressed
				darkTextColor:(BOOL)darkTextColor
{	
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	// or you can do this:
	//		UIButton *button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	//		button.frame = frame;
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];	
	if (darkTextColor)
	{
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	}
	else
	{
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
	
	return button;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
{
	UITextField* textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.textColor = [UIColor blackColor];
	//textField.font = [UIFont systemFontOfSize:17.0];
	textField.placeholder = @"";
	textField.backgroundColor = [UIColor whiteColor];
	textField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	textField.keyboardType = UIKeyboardTypeDefault;
	textField.returnKeyType = UIReturnKeyDone;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
	return textField;
	
}

+ (UIAlertView*)alertActionAutoRelease:(NSString *)title message:(NSString *)msg
{	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title 
												  message:msg
												 delegate:nil 
										   cancelButtonTitle:NSLocalizedString(@"sure",nil)
										otherButtonTitles:nil, nil] autorelease];
	//alert.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"action_bg.png"]];
	return alert;	
}

+ (UIAlertView *)alertAction:(NSString *)title message:(NSString *)msg
{	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:msg
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(@"cancel",nil)
										  otherButtonTitles:NSLocalizedString(@"sure",nil), nil];	
	return alert;	
}

+ (UIAlertView *) alertActionAgree:(NSString *)title message:(NSString *)msg
{	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:msg
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(@"notagree",nil)
										  otherButtonTitles:NSLocalizedString(@"agree",nil), nil];	
	return alert;	
}

+ (UIActionSheet *)dialogAction:(NSString *)title delegate:(id)target
{
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
															 delegate:target 
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	return actionSheet;
}

+ (UIView *)waitAction:(NSString *)title background:(UIColor *)color
{
	UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[bkView setBackgroundColor:color];
	[bkView setAlpha:0.6];
	
	UIView *wait = [[UIView alloc] initWithFrame:CGRectMake(120, 190, 80, 80)];
	[wait setBackgroundColor:[UIColor clearColor]];
	[wait setAlpha:1];
	
	UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
	bg.image = [UIImage imageNamed:@"wait_bg.png"];
	[bg setBackgroundColor:[UIColor clearColor]];
	[wait addSubview:bg];
	[bg release];
	
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner sizeToFit];
	spinner.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleBottomMargin);
	spinner.frame = CGRectMake(20, 40, 37, 37);
	[spinner startAnimating];
	[wait addSubview:spinner];
	[spinner release];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
	titleLabel.text = title;
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	[wait addSubview: titleLabel];
	[titleLabel release];
	
	[bkView addSubview:wait];
	[wait release];
	return bkView;
}

+ (UIView *)heightwaitAction:(NSString *)title background:(UIColor *)color
{
	UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[bkView setBackgroundColor:color];
	[bkView setAlpha:0.8];
	
	UIView *wait = [[UIView alloc] initWithFrame:CGRectMake(120, 130, 80, 80)];
	[wait setBackgroundColor:[UIColor clearColor]];
	[wait setAlpha:1];
	
	UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
	bg.image = [UIImage imageNamed:@"wait_bg.png"];
	[bg setBackgroundColor:[UIColor clearColor]];
	[wait addSubview:bg];
	[bg release];
	
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner sizeToFit];
	spinner.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleBottomMargin);
	spinner.frame = CGRectMake(20, 40, 37, 37);
	[spinner startAnimating];
	[wait addSubview:spinner];
	[spinner release];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
	titleLabel.text = title;
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	[wait addSubview: titleLabel];
	[titleLabel release];
	
	[bkView addSubview:wait];
	[wait release];
	return bkView;
}
@end
