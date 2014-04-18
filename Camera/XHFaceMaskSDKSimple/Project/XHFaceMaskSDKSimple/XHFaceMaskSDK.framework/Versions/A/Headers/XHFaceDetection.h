//
//  XHFaceDetection.h
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface XHFaceDetection : NSObject
- (void)_setupFaceDetection:(UIView *)preview;
- (void)_startRunning:(AVCaptureDevice *)videoDevice previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer;
- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;
@end
