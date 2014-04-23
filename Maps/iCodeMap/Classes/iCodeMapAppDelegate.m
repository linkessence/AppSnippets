//
//  iCodeMapAppDelegate.m
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iCodeMapAppDelegate.h"
#import "iCodeMapViewController.h"

@implementation iCodeMapAppDelegate

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
