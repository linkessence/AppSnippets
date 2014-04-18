
#import <UIKit/UIKit.h>

@interface WTStatusBar : NSObject

// ---------------------------------------------------
// status bar appearance
// ---------------------------------------------------

+ (UIColor*) backgroundColor;
+ (void) setBackgroundColor:(UIColor*)backgroundColor;


// ---------------------------------------------------
// status manipulation
// ---------------------------------------------------

+ (void) clearStatus;
+ (void) clearStatusAnimated:(BOOL)animated;


+ (void) setLoading:(BOOL)animated loadAnimated:(BOOL)loadAnimated;

@end
