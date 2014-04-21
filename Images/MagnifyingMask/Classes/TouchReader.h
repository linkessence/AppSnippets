//
//  TouchReader.h
//  SimplerMaskTest
//

#import <UIKit/UIKit.h>
#import "MagnifierView.h"

@interface TouchReader : UIView {
	NSTimer *touchTimer;
	MagnifierView *loop;
}

@property (nonatomic, retain) NSTimer *touchTimer;

- (void)addLoop;
- (void)handleAction:(id)timerObj;

@end
