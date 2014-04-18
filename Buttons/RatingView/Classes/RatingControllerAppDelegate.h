//
//  RatingControllerAppDelegate.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingControllerViewController;

@interface RatingControllerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RatingControllerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RatingControllerViewController *viewController;

@end

