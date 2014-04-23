//
//  XQImageOverlay.h
//  XQMapTest
//
//  Created by xf.lai on 13-7-16.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKOverlay.h"

@interface XQImageOverlay : NSObject<BMKOverlay>

- (BMKMapRect)boundingMapRect;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic,strong)UIImage *image;

@end
