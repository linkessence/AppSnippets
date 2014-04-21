//
//  UIImageView+RZWebImage.h
//  FMDBDemo
//
//  Created by Reese Zhang @墨半成霜. on 13-10-31.
//  Copyright (c) 2013年 Reese Zhang @墨半成霜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RZImageDisplay.h"

@interface UIImageView (RZWebImage)<RZImageDisplayDelegate>


-(void)setWebImage:(NSURL *)aUrl placeHolder:(UIImage *)placeHolder downloadFlag:(int)flag;

@end
