//
//  iCodeMapAppDelegate.h
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iCodeMapViewController;

@interface iCodeMapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iCodeMapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iCodeMapViewController *viewController;

@end

