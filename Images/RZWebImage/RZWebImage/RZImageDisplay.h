//
//  RZImageDisplay.h
//  FMDBDemo
//
//  Created by Reese on 13-10-31.
//  Copyright (c) 2013年 Reese@objcoder.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RZImageDisplayDelegate <NSObject>
@required
-(void)willEndDisplay;

@end

@interface RZImageDisplay : UIView
{
    IBOutlet UIScrollView *backScroll;
    
}
@property (nonatomic,assign) id<RZImageDisplayDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *frontImageView;
//变化前的frame
@property (assign,nonatomic) CGRect originFrame;
@property (weak, nonatomic) UIImage *frontImage;
- (IBAction)makeZoom:(UIStepper *)sender;
- (IBAction)closeView:(id)sender;
@end
