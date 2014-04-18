

#import <UIKit/UIKit.h>

@interface CirActivityIndicatorView : UIView
{
    BOOL isAnimating;
    int circleNumber;
    int maxCircleNumber;
    float circleSize;
    float radius;
    UIColor *color;
    NSTimer *circleDelay;
}

@property (nonatomic,retain) UIColor *color;

-(id)initWithFrame:(CGRect)frame andColor:(UIColor*)theColor;

-(void)startAnimating;

-(void)stopAnimating;

-(BOOL)isAnimating;

@end
