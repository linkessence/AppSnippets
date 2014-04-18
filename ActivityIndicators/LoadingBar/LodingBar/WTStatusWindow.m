#import "WTStatusWindow.h"
#import "WTStatusView.h"

@implementation WTStatusWindow

@synthesize iteration = _iteration;

- (id)init
{
    self = [super init];
    if (self) {
        [self initWindow];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initWindow];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initWindow];
    }
    return self;
}

- (void)initWindow
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    self.frame = screenRect;
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelStatusBar;
    self.userInteractionEnabled = NO;
    self.autoresizesSubviews = YES;
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    _statusView = [[WTStatusView alloc] initWithFrame:statusBarRect];
    
    [self addSubview:_statusView];
    
    [self didRotate:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    _statusView = nil;
}

- (WTStatusView*)statusView
{
    return _statusView;
}

- (void)didRotate:(NSNotification*)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [self setTransform:[self transformForOrientation:orientation]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        self.bounds = CGRectMake(0, 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
        self.statusView.frame = CGRectMake(0, 0, CGRectGetWidth(statusBarRect), CGRectGetHeight(statusBarRect));
    }
    else
    {
        self.bounds = CGRectMake(0, 0, CGRectGetHeight(screenRect), CGRectGetWidth(screenRect));
        self.statusView.frame = CGRectMake(0, 0, CGRectGetHeight(statusBarRect), CGRectGetWidth(statusBarRect));
    }
    
    [self.statusView setNeedsLayout];
}

#define DegreesToRadians(degrees) (degrees * M_PI / 180)

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(-DegreesToRadians(90));
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(DegreesToRadians(90));
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(DegreesToRadians(180));
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformMakeRotation(DegreesToRadians(0));
    }
}

@end
