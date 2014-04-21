//
//  RZImageDisplay.m
//  FMDBDemo
//
//  Created by Reese on 13-10-31.
//  Copyright (c) 2013年 Reese@objcoder.com. All rights reserved.
//

#import "RZImageDisplay.h"

@implementation RZImageDisplay

- (id)initWithFrame:(CGRect)frame
{
    self = [[NSBundle mainBundle]loadNibNamed:@"RZImageDisplay" owner:self options:nil][0];
    if (self) {
        // Initialization code
        __weak id weakSelf=self;
        [backScroll setDelegate:weakSelf];
    }
    return self;
}
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.frontImage);
    CGRect currentFrame=self.frontImageView.frame;
    [self.frontImageView setFrame:self.originFrame];
    [self.frontImageView setImage:self.frontImage];
    [UIView animateWithDuration:0.5 animations:^{
        [self.frontImageView setFrame:currentFrame];
    }];
}



- (IBAction)makeZoom:(UIStepper *)sender {
    NSLog(@"缩放:%f",sender.value);
    [backScroll setZoomScale:sender.value animated:YES];
}

- (IBAction)closeView:(id)sender {
    [backScroll setZoomScale:1.0 animated:YES];
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.5 animations:^{
            [self.frontImageView setFrame:self.originFrame];
        } completion:^(BOOL finished) {
            
            [self.delegate willEndDisplay];
            [self removeFromSuperview];
            
            
            
            
        }];

    });
    
    
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.frontImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
