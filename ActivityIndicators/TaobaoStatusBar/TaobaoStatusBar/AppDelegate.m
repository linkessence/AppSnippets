//
//  AppDelegate.m
//  淘宝状态栏
//
//  Created by Jian on 13-6-27.
//  Copyright (c) 2013年 Jian. All rights reserved.
//

#import "AppDelegate.h"



@implementation AppDelegate

- (void)dealloc
{
    [_page release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[UIViewController alloc] init] autorelease];
    self.viewController.view.backgroundColor=[UIColor greenColor];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
    self.page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    self.page.backgroundColor=[UIColor clearColor];
    self.page.numberOfPages=3;
    
    UIWindow *mi_statusbar=[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    mi_statusbar.center=CGPointMake(160, 10);
    [mi_statusbar addSubview:self.page];
    mi_statusbar.backgroundColor=[UIColor blackColor];
    [mi_statusbar setHidden:NO];
    mi_statusbar.windowLevel = UIWindowLevelStatusBar + 1.0f;
    mi_statusbar.alpha=1;
    
    [self.page release];
    
    NSTimer *timer=[NSTimer timerWithTimeInterval:0.2f target:self selector:@selector(pageNumberChanged) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    return YES;
}
-(void)pageNumberChanged
{
    static int i=0;
    i++;
    i=i>2?0:i;
    self.page.currentPage=i;
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
