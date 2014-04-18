//
//  VideoCamera2AppDelegate.h
//  VideoCamera2
//
//  Created by matao.ct@gmail.com on 12-6-4.
//  Copyright 2012 __福州微泰网络__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCamera.h"

@interface VideoCamera2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	VideoCamera *videoCamera;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) VideoCamera *videoCamera;



-(NSString *)myNumber;

@end

