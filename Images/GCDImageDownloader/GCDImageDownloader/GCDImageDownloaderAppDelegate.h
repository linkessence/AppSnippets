//
//  GCDImageDownloaderAppDelegate.h
//  GCDImageDownloader
//
//  Created by Slava on 5/22/11.
//  Copyright 2011 Alterplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCDImageDownloaderViewController;

@interface GCDImageDownloaderAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GCDImageDownloaderViewController *viewController;

@end
