//
//  XHFaceFeature.h
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-5.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XHFaceMask;

@interface XHFaceFeature : NSObject

- (id)initWithID:(NSString *) identifier andImage:(UIImage *)image andDescriptor:(XHFaceMask *)descriptor;

@property (nonatomic, strong) XHFaceMask *descriptor;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *identifier;

@end
