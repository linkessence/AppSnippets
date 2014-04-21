//
//  NZAppDelegate.m
//  UIImage-Helpers
//
//  Created by Bruno Tortato Furtado on 21/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZAppDelegate.h"

@implementation NZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor], UITextAttributeTextColor, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:dictionary];
    
    return YES;
}

@end
