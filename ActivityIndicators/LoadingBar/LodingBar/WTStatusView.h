
#import <UIKit/UIKit.h>
#import "CirActivityIndicatorView.h"

@interface WTStatusView : UIView
{
    CirActivityIndicatorView * etActivity;
}

- (void) setActivityAnimating:(BOOL)animation;
- (void)setStatusBarColor:(UIColor *)color;
@end
