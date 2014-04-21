//
//  DJQRateView.m
//  rateView
//
//  Created by 丁剑青 on 13-6-23.
//  Copyright (c) 2013年 丁剑青. All rights reserved.
//

#import "DJQRateView.h"
#import "DJQStartView.h"

@interface DJQRateView()

@property(nonatomic) CGRect minImageSize;
@property(nonatomic,strong) NSMutableArray *rateViews;
-(void) baseInit;
-(void) refresh;
@end
@implementation DJQRateView

-(void) baseInit
{
    self.rateViews = [[NSMutableArray alloc] init];
    
    self.rate = 0;
    self.maxRate = 5;
    
    self.leftMargin = 0;
    self.rightMargin = 0;
    self.midMargin = 8;
    
    self.minImageSize = CGRectMake(0, 0, 16, 16);

}
-(void) refresh
{
    int size = self.rateViews.count;
    for (int i = 0; i < size; i ++) {
        DJQStartView *view = [self.rateViews objectAtIndex:i];
        if (self.rate >= i + 1) {
            view.value = 1;
        }
        else if(self.rate > i)
        {
            view.value = self.rate - i;
        }
        else{
            view.value = 0;
        }
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    
    float desireImageViewWidth = (self.frame.size.width - self.leftMargin -self.rightMargin - self.midMargin * (self.maxRate - 1)) / self.maxRate;
    float imageWidth = MAX(self.minImageSize.size.width,desireImageViewWidth);
    float imageHeight = MAX(self.frame.size.height,self.minImageSize.size.height);
    
    int size = self.rateViews.count;
    UIImageView *view = NULL;
    
    for (int i = 0; i<size; i ++) {
        view = [self.rateViews objectAtIndex:i];
        view.frame = CGRectMake(self.leftMargin + (self.midMargin +imageWidth)* i , 0, imageWidth, imageHeight);
    }
    
    
}


-(void)setMaxRate:(int)maxRate
{
    _maxRate = maxRate;
    int size = self.rateViews.count;
    DJQStartView *view = NULL;
    if (size > maxRate) {
        
        for (int i = size - 1; size >= maxRate; i --) {
            view = (DJQStartView*) [self.rateViews objectAtIndex:i];
            [view removeFromSuperview];
            [self.rateViews removeObjectAtIndex:i];
        }
        [self setNeedsLayout];
        [self refresh];
    } else {
        for (int i = size; i < maxRate; i ++) {
            view = [[DJQStartView alloc] initWithFrame:CGRectMake(0, 0, 10 , 10)];
           // view.startColor =
            [self.rateViews addObject:view];
            [self addSubview:view];
        }
        [self setNeedsLayout];
        [self refresh];
    }
}

-(void) setRate:(float)rate
{
    _rate = rate;
    [self refresh];
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
