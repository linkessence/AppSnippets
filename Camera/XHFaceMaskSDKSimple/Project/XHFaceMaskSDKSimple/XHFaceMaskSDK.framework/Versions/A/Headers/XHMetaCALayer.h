//
//  XHMetaCALayer.h
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-5.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum {
    MetaCALayerOriginCenter,
    MetaCALayerOriginLeftTop,
    MetaCALayerOriginLeftBottom
} MetaCALayerOrigin;

@interface XHMetaCALayer : CALayer

@property (nonatomic, readonly) CGSize metaOriginalContentSize;

- (void)metaSetUIImageContent:(UIImage *)image;
- (CGRect)metaSetWidth:(float)width;
- (CGRect)metaSetWidth:(float)width andFlip: (BOOL)flip;

- (void)metaSetFrameX:(float)x Y:(float)y Origin:(MetaCALayerOrigin) origin;

- (void)metaSetFrameLeft:(float)x Top:(float) y;
- (void)metaSetFrameLeft:(float)x Bottom:(float) y;
- (void)metaSetFrameCenterX:(float)x Y:(float)y;

@end
