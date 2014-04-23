//
//  XQImageOverlayView.m
//  XQMapTest
//
//  Created by xf.lai on 13-7-17.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import "XQImageOverlayView.h"
#import <QuartzCore/QuartzCore.h>



//处理倒置问题
CGImageRef flip(CGImageRef im){

    CGSize sz=CGSizeMake(CGImageGetWidth(im),CGImageGetHeight(im));
    
    UIGraphicsBeginImageContextWithOptions(sz,NO,0);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0,0,sz.width,sz.height),im);
    
    
    CGImageRef result=[UIGraphicsGetImageFromCurrentImageContext()CGImage];
    
       
    UIGraphicsEndImageContext();
    
    
    return result;
    
}


@implementation XQImageOverlayView


//必要时压缩图片
-(UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
    从2.0.0开始矢量地图采用OpenGL绘制，新增支持OpenGL绘制的基本线绘制、面绘制接口。
    栅格地图：drawMapRect默认使用系统GDI绘制，GDI绘制方式在overlayView尺寸较大时可能有效率问题
 */
- (void)drawMapRect:(BMKMapRect)mapRect zoomScale:(BMKZoomScale)zoomScale inContext:(CGContextRef)ctx
{

    UIImage *image  = [UIImage imageNamed:@"3.png"];
    CGFloat scale = 640/image.size.width;
    if (scale <1) {
        image = [self scaleFromImage:image toSize:CGSizeMake(image.size.width*scale, image.size.height*scale)];
    }
   
    CGImageRef imageReference = image.CGImage;
    
    //Loading and setting the image
    BMKMapRect theMapRect    = [self.overlay boundingMapRect];
    CGRect theRect           = [self rectForMapRect:theMapRect];

    CGContextDrawImage(ctx, theRect, flip(imageReference));    
}



@end
