//
//  TestAppDelegate.h
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewController;

@interface TestAppDelegate : NSObject <UIApplicationDelegate, UIImagePickerControllerDelegate>
{
  UIWindow *window;
  TestViewController *vc;
}

@end

