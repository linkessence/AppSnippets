//
//  UIImageRotationFixer.h
//  ReKo SDK
//
//  Created by Kuang Han on 11/7/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageRotationFixer : NSObject
// Rotate the underlining CGImageRef of an UIImage to its up un-mirrored position. This function is potentially expensive since its redraws the whole bitmap.
+ (UIImage *)fixOrientation:(UIImage *)rawImage;
@end
