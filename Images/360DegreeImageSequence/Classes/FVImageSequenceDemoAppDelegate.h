//
//  FVImageSequenceDemoAppDelegate.h
//  FVImageSequenceDemo
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FVImageSequenceDemoViewController;

@interface FVImageSequenceDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FVImageSequenceDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FVImageSequenceDemoViewController *viewController;

@end

