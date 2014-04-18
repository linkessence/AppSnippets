

#import "WTStatusView.h"

#define kWTProgressBarHeight 2

@implementation WTStatusView



- (id)init
{
    self = [super init];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor blackColor];
    
    etActivity = [[CirActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 10, 350, 60)];
    [self addSubview:etActivity];

    
}

- (void)dealloc
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //etActivity.frame = self.bounds;
}

- (void)setStatusBarColor:(UIColor *)color
{
    CGFloat windowAlpha = ([[UIApplication sharedApplication] statusBarStyle] == UIStatusBarStyleBlackTranslucent) ? 0.5 : 1.0;
    self.backgroundColor = [color colorWithAlphaComponent:windowAlpha];
}



-(void)setActivityAnimating:(BOOL)animation{
    if (animation) {
        [etActivity startAnimating];
    }else
        [etActivity stopAnimating];
}

@end
