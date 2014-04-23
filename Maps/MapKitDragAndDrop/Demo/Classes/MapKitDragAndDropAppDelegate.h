//
//  MapKitDragAndDropAppDelegate.h
//  MapKitDragAndDrop
//
//  Created by digdog on 11/1/10.
//  Copyright 2010 Ching-Lan 'digdog' HUANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapKitDragAndDropViewController;

@interface MapKitDragAndDropAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapKitDragAndDropViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapKitDragAndDropViewController *viewController;

@end

