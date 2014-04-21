//
//  TranslucentAppDelegate.h
//  Translucent
//
//  Created by 谢伟 on 11-2-14.
//  Copyright 2011 易联伟达 www.e-linkway.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TranslucentViewController;

@interface TranslucentAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TranslucentViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TranslucentViewController *viewController;

@end

