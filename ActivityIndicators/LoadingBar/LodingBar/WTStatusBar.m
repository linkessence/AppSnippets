
#import "WTStatusBar.h"
#import "WTStatusWindow.h"
#import "WTStatusView.h"
#import <objc/runtime.h>
#import "CirActivityIndicatorView.h"

#define kWTStatusBarWindow @"StatusBarWindow"
#define kWTFadeDuration 0.2
#define kWTProgressDuration 0.1

static UIColor* _backgroundColor = nil;


@implementation WTStatusBar

+ (void)initialize
{
    _backgroundColor = [UIColor blackColor];
}


+ (UIColor*)backgroundColor
{
    return _backgroundColor;
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor
{
    NSParameterAssert(backgroundColor != nil);
    _backgroundColor = backgroundColor;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow != nil)
    {
        WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
        if (statusWindow != nil)
            [statusWindow.statusView setStatusBarColor:_backgroundColor];
    }
}


+ (void)clearStatus
{
    [WTStatusBar clearStatusAnimated:NO];
}

+ (void)clearStatusAnimated:(BOOL)animated
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow == nil) return;
    
    WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
    if (statusWindow != nil)
    {
        if (animated)
        {
            [UIView animateWithDuration:kWTFadeDuration animations:^{
                statusWindow.alpha = 0.0;
            } completion:^(BOOL finished) {
                statusWindow.hidden = YES;
            }];
        }
        else
        {
            statusWindow.hidden = YES;
        }
    }
}


+(void)setLoading:(BOOL)animated loadAnimated:(BOOL)loadAnimated{
    
    //UES STORYBOARD
    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
    
    //UES XIB
    //UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (mainWindow == nil) return;
    // create status window if it not exists
    
    WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
    if (statusWindow == nil)
    {
        statusWindow = [[WTStatusWindow alloc] init];
        statusWindow.alpha = 0.0;
        statusWindow.hidden = YES;
        
        objc_setAssociatedObject(mainWindow, kWTStatusBarWindow, statusWindow, OBJC_ASSOCIATION_RETAIN);
    }

    
    [statusWindow.statusView setStatusBarColor:_backgroundColor];
    [statusWindow.statusView setActivityAnimating:loadAnimated];
    if (animated)
    {
        [UIView animateWithDuration:kWTFadeDuration animations:^{
            statusWindow.hidden = NO;
            statusWindow.alpha = 1.0;
        }];
    }
    else
    {
        statusWindow.alpha = 1.0;
        statusWindow.hidden = NO;
    }

    
}


@end
