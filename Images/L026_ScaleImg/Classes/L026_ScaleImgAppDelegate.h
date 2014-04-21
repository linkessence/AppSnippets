//
//  L026_ScaleImgAppDelegate.h
//  L026_ScaleImg
//
//  Created by jiaqiu on 11-7-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class L026_ScaleImgViewController;

@interface L026_ScaleImgAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    L026_ScaleImgViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet L026_ScaleImgViewController *viewController;

@end

