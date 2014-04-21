//
//  LLAppDelegate.m
//  WebImagesLazyLoadDemo
//
//  Created by Reese on 13-4-4.
//  Copyright (c) 2013年 Himalayas Technology Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import "LLAppDelegate.h"

@implementation LLAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //首次打开APP 创建缓存文件夹
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"firstLaunch"]==nil) {
        [[NSFileManager defaultManager] createDirectoryAtPath:pathInCacheDirectory(@"com.xmly") withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"firstLaunch"];
    }
    UITabBarController *tab=[[UITabBarController alloc]init];
    DemoViewController *llView=[[DemoViewController alloc]init];
    NearFriendsController *friendView=[[NearFriendsController alloc]init];
    
    [llView setTabBarItem:[[[UITabBarItem alloc]initWithTitle:@"汽车品牌Demo" image:[UIImage imageNamed:@"icon"] tag:1]autorelease]];
     [friendView setTabBarItem:[[[UITabBarItem alloc]initWithTitle:@"2000头像Demo" image:[UIImage imageNamed:@"icon"] tag:2]autorelease]];
    [tab setViewControllers:[NSArray arrayWithObjects:llView,friendView, nil]];
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:tab];
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
