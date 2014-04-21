//
//  MaskImageView.m
//  image
//
//  Created by itensen001 on 13-3-21.
//  Copyright (c) 2013年 czj. All rights reserved.
//

#import "MaskImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface MaskImageView ()
@end
@implementation MaskImageView
@synthesize thumImageView;

- (void)dealloc {
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
      NSLog(@"mask");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    thumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    thumImageView.center = point;
    [self addSubview:thumImageView];
    UIImage *image = [self getImageInPoint:point];
    thumImageView.image = image;
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[[UIImage imageNamed:@"4.png"] CGImage];
    mask.frame = CGRectMake(0, 0, 70, 70);
    thumImageView.layer.mask = mask;
    thumImageView.layer.masksToBounds = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    thumImageView.center = point;
    UIImage *image = [self getImageInPoint:point];
    thumImageView.image = image;
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[[UIImage imageNamed:@"4.png"] CGImage];
    mask.frame = CGRectMake(0, 0, 70, 70);
    thumImageView.layer.mask = mask;
    thumImageView.layer.masksToBounds = YES;
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        [thumImageView removeFromSuperview];
        [thumImageView release];
        thumImageView = nil;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (thumImageView) {
        [thumImageView removeFromSuperview];
        [thumImageView release];
        thumImageView = nil;
    }
}

-(UIImage *)getImageInPoint:(CGPoint)point{
    UIImage* bigImage= [UIImage imageNamed:@"5.png"];
    CGFloat x = point.x * bigImage.size.width/self.frame.size.width -35;
    CGFloat y = point.y * bigImage.size.height/self.frame.size.height -35;
    CGRect rect = CGRectMake(x, y, 70, 70);
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    CGSize size;
    size.width = 70;
    size.height = 70;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}
@end



