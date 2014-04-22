//
//  ViewController.m
//  MutilColor_Label
//
//  Created by zyq on 13-4-27.
//  Copyright (c) 2013年 zyq. All rights reserved.
//

#import "ViewController.h"
#import "MarkupParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
     注，此处的color对应的值必须是系统预定义好的，有
     + (UIColor *)blackColor;      // 0.0 white
     + (UIColor *)darkGrayColor;   // 0.333 white
     + (UIColor *)lightGrayColor;  // 0.667 white
     + (UIColor *)whiteColor;      // 1.0 white
     + (UIColor *)grayColor;       // 0.5 white
     + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
     + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
     + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
     + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
     + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
     + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
     + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
     + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
     + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
     + (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
     否则，程序会crash。
     */
    NSString *text = @"Hello <font color=\"red\">core text <font color=\"blue\">world!\nHello <font color=\"lightGray\">core text <font color=\"green\">world!";//[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    MarkupParser *p = [[[MarkupParser alloc]init ]autorelease];
    NSAttributedString *attString = [p attrStringFromMarkup:text];
    [self.customLabel setAttString:attString];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_customLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCustomLabel:nil];
    [super viewDidUnload];
}
@end
