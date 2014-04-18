//
//  IBPLightViewController.h
//  IBPLight
//
//  Created by 朱克锋 on 13-2-17.
//  Copyright (c) 2013年 朱克锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface IBPLightViewController : UIViewController
{
      bool isFlashOn;
}
@property  bool isLightOn;
-(void) turnOff:(bool)update;
-(void) turnOn:(bool)update;
@end