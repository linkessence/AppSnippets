//
//  RatingControllerAppDelegate.m
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RatingControllerAppDelegate.h"
#import "RatingControllerViewController.h"

@implementation RatingControllerAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
