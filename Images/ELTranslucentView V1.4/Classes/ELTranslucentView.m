//
//  TranslucentView.m
//  Translucent
//
//  Created by 谢伟 on 11-2-14.
//  Copyright 2011 易联伟达 www.e-linkway.com. All rights reserved.
//

#import "ELTranslucentView.h"

@implementation ELTranslucentView

@synthesize backgroundImage;
@synthesize translucentImage;

@synthesize moveMinY = _moveMinY;
@synthesize moveMaxY = _moveMaxY;

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.userInteractionEnabled = YES;
		
		_moveMinY = 10;
		_moveMaxY = 10;
    }

    return self;
}

-(void) initLayout
{
    self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"e-linkway.png"]];

    NSLog(@"self = %@", self);

    if (self.backgroundImage)
    {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame: self.bounds];
        backgroundImageView.image = self.backgroundImage;
        [self addSubview: backgroundImageView];
        [backgroundImageView release];

        NSLog(@"backgroundImageView = %@", backgroundImageView);
    }

    UIImage *boundsBorderImage = [UIImage imageNamed: @"bounds.png"];
    
    if (!boundsBorderImage)
    {
        return;
    }
    
    if (!self.translucentImage)
    {
        return;
    }

    float boundsViewWidth = boundsBorderImage.size.width * (self.frame.size.width / self.backgroundImage.size.width);
    float boundsViewHeight = boundsBorderImage.size.height * (self.frame.size.height / self.backgroundImage.size.height);
    
    float boundsViewX = (self.frame.size.width - boundsViewWidth) / 2;
    float boundsViewY = (self.frame.size.height - boundsViewHeight) / 2;

    
    // a frame
    _boundsView = [[UIView alloc] initWithFrame: CGRectMake(boundsViewX, boundsViewY, boundsViewWidth, boundsViewHeight)];
    _boundsView.backgroundColor = [UIColor redColor];
    _boundsView.clipsToBounds = YES;
    _boundsView.userInteractionEnabled = YES;

    // 透视汽车
    _contentImageView = [[UIImageView alloc] initWithFrame: CGRectMake(-boundsViewX, -boundsViewY, self.frame.size.width, self.frame.size.height)];
    _contentImageView.image = self.translucentImage;
    [_boundsView addSubview: _contentImageView];
    [_contentImageView release];

    UIImageView *boundsBorderImageView = [[UIImageView alloc] initWithImage: boundsBorderImage];
    boundsBorderImageView.frame = _boundsView.bounds;
    NSLog(@"boundsBorderImageView = %@", boundsBorderImageView);
    [_boundsView addSubview: boundsBorderImageView];
    [boundsBorderImageView release];
    
    [self addSubview: _boundsView];
    [_boundsView release];
}

-(void) didMoveToSuperview
{
    static BOOL isInited = FALSE;
    
    if (!isInited) 
    {
        [self initLayout];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _firstPoint = [touch locationInView: self];

    _isDragBegan = [_boundsView pointInside: [touch locationInView: _boundsView] 
                                  withEvent: event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isDragBegan)
    {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint prePoint = [touch previousLocationInView: self];
    CGPoint secondPoint = [touch locationInView: self];
    
    //float moveX = secondPoint.x - prePoint.x;
    float moveY = secondPoint.y - prePoint.y;
    
    if ((_boundsView.center.y + moveY < _boundsView.frame.size.height / 2 + _moveMinY) ||
        (_boundsView.center.y + moveY > self.frame.size.height - _boundsView.frame.size.height / 2 - _moveMaxY))
    {
        return;
    }

    _boundsView.center = CGPointMake(_boundsView.center.x,_boundsView.center.y+moveY);
    
    _contentImageView.center = CGPointMake(_contentImageView.center.x, _contentImageView.center.y + (-moveY));
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isDragBegan = NO;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
