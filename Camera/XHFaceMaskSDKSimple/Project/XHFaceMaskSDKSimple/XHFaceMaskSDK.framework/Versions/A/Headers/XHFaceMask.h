//
//  XHFaceMask.h
//  XHFaceMask
//
//  Created by 曾 宪华 on 14-1-5.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>

#import "XHMetaCALayer.h"

typedef float (^FaceFeatureDescriptorAdjuster)(CIFaceFeature * face, CGSize featureSize, CGRect transformedFaceRect);
typedef CGRect (^FaceFeatureRectConverter)(CGRect faceRect);

@interface XHFaceMask : NSObject

- (id)initWithWidthRatioOfFace:(float)widthRatioOfFace
                    andOrigin:(MetaCALayerOrigin)origin
                 andXAdjuster:(FaceFeatureDescriptorAdjuster)xAdjuster
                 andYAdjuster:(FaceFeatureDescriptorAdjuster)yAdjuster;

@property (nonatomic) MetaCALayerOrigin origin;
@property (nonatomic) float widthRatioOfFace;
@property (nonatomic, strong) FaceFeatureDescriptorAdjuster xAdjuster;
@property (nonatomic, strong) FaceFeatureDescriptorAdjuster yAdjuster;
- (void)adjustLayer:(XHMetaCALayer *)layer withFace: (CIFaceFeature *)face transformedFaceRect:(CGRect) faceRect rectConverter:(FaceFeatureRectConverter) converter;

@end

@interface FaceFeatureDescriptor : XHFaceMask

@end

