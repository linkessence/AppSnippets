//
//  XHCommonFunctions.h
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-5.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface XHCommonFunctions : NSObject

+ (CGRect)videoPreviewBoxForGravity:(NSString *)gravity frameSize:(CGSize)frameSize apertureSize:(CGSize)apertureSize;
+ (int)getDeviceExifOrientation:(AVCaptureDevice *)videoDevice;
@end
