//
//  ViewController.m
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize labelView, titleView, fillTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, screen.width, screen.height - 64)];
    [self.view addSubview:contentView];
    
    UIImageView* banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [contentView addSubview:banner];
    
    
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.width, 44)];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    UIImageView* fdLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fourdesire-logo"]];
    fdLogo.frame = CGRectMake(20, 18, 0, 0);
    [fdLogo sizeToFit];
    [header addSubview:fdLogo];
    
    UILabel* debugLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.width - 160, 11, 70, 24)];
    debugLabel.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
    debugLabel.text = @"Debug Mode";
    debugLabel.font = [UIFont boldSystemFontOfSize:10];
    [header addSubview:debugLabel];
    
    UISwitch* debugSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screen.width - 90, 10, 0, 0)];
    debugSwitch.on = YES;
    [debugSwitch addTarget:self action:@selector(debugSwitch:) forControlEvents:UIControlEventValueChanged];
    [header addSubview:debugSwitch];

    
    labelView = [[FDLabelView alloc] initWithFrame:CGRectMake(159.8, 160.5, 147.5, 28.6)];
    labelView.backgroundColor = [UIColor colorWithWhite:1.00 alpha:1.00];
    labelView.textColor = [UIColor colorWithWhite:0.00 alpha:1.00];
    labelView.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:25];
    labelView.minimumScaleFactor = 0.50;
    labelView.numberOfLines = 0;
    labelView.text = @"EASY TO LAYOUT TEXT WITHOUT PAINS AND TEDIOUS PROCESS.讓你輕鬆快速的排版，省去痛苦繁雜的來回過程。";
    labelView.shadowColor = nil; // fill your color here
    labelView.shadowOffset = CGSizeMake(0.0, -1.0);
    labelView.lineHeightScale = 0.62;
    labelView.fixedLineHeight = 0.00;
    labelView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    labelView.fdTextAlignment = FDTextAlignmentFill;
    labelView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    labelView.fdLabelFitAlignment = FDLabelFitAlignmentTop;
    labelView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [contentView addSubview:labelView]; // Attach your view here
    // Debug properties
    labelView.outputName = @"labelView";
    labelView.debugShowLineBreaks = YES;
    labelView.debugShowCoordinates = YES;
    labelView.debugShowFrameBounds = YES;
    labelView.debugShowPaddings = YES;
    labelView.debugParentView = self.view; // specify view for debug panel here.
    labelView.debugSentences = @[
                                 @"EASY TO LAYOUT TEXT WITHOUT PAINS AND TEDIOUS PROCESS",
                                 @"讓你輕鬆快速的排版，省去痛苦繁雜的來回過程。",
                                 @"痛みや面倒なプロセスなしレイアウトテキストには簡単にさせて"                  ];
    labelView.debug = YES;

    // End
   
    
    titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(13.5, 12.0, 231.5, 44.3)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    titleView.textColor = [UIColor colorWithHue:0.57 saturation:0.87 brightness:0.82 alpha:0.80];
    titleView.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:35.5];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = @"FDLABELVIEW";
    titleView.shadowColor = nil; // fill your color here
    titleView.shadowOffset = CGSizeMake(0.0, -1.0);
    titleView.lineHeightScale = 0.70;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentFill;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentTop;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [contentView addSubview:titleView]; // Attach your view here
    // Debug properties
    titleView.outputName = @"titleView";
    titleView.debugShowLineBreaks = YES;
    titleView.debugShowCoordinates = YES;
    titleView.debugShowFrameBounds = YES;
    titleView.debugShowPaddings = YES;
    titleView.debugParentView = self.view; // specify view for debug panel here.
    titleView.debugSentences = @[
                                 @"Fourdesire 四合願"                  ];
    titleView.debug = YES;

    fillTextView = [[FDLabelView alloc] initWithFrame:CGRectMake(50.0, 130.5, 220.0, 19.8)];
    fillTextView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    fillTextView.textColor = [UIColor colorWithWhite:0.60 alpha:0.80];
    fillTextView.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:11.5];
    fillTextView.minimumScaleFactor = 0.50;
    fillTextView.numberOfLines = 1;
    fillTextView.text = @"© 2013 FOURDESIRE CO., LTD.";
    fillTextView.shadowColor = nil; // fill your color here
    fillTextView.shadowOffset = CGSizeMake(0.0, -1.0);
    fillTextView.lineHeightScale = 0.70;
    fillTextView.fixedLineHeight = 0.00;
    fillTextView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineTop;
    fillTextView.fdTextAlignment = FDTextAlignmentCenter;
    fillTextView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    fillTextView.fdLabelFitAlignment = FDLabelFitAlignmentTop;
    fillTextView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [contentView addSubview:fillTextView]; // Attach your view here
    // Debug properties
    fillTextView.outputName = @"fillTextView";
    fillTextView.debugShowLineBreaks = YES;
    fillTextView.debugShowCoordinates = YES;
    fillTextView.debugShowFrameBounds = YES;
    fillTextView.debugShowPaddings = YES;
    fillTextView.debugParentView = self.view; // specify view for debug panel here.
    fillTextView.debugSentences = @[
                                    @"Fourdesire 四合願"                  ];
    fillTextView.debug = YES;

    
    _debug = YES;
}

-(void)debugSwitch:(UISwitch*)sender{
    _debug = sender.on;
    labelView.debug = _debug;
    titleView.debug = _debug;
    fillTextView.debug = _debug;
}


@end
