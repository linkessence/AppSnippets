//
//  AppDelegate.m
//  ButtonBoardTest
//
//  Created by 孙 化育 on 13-8-28.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "AppDelegate.h"
#import "SUNButtonBoard.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = nav;
    
    SUNButtonBoard *board = [SUNButtonBoard defaultButtonBoard];
    board.boardImage = [UIImage imageNamed:@"button3.png"];
    board.buttonNumber = 3;
    NSArray *imgArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"button1.png"],
                         [UIImage imageNamed:@"button2.png"],
                         [UIImage imageNamed:@"button3.png"],nil];
    board.buttonImageArray = imgArray;
    if (!board.running) {
        [board startRunning];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
