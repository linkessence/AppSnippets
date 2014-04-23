//
//  MapOverlayView.m
//  MapOverlay
//
//  Created by Raphael Petegrosso on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapOverlayView.h"
#import "MapOverlay.h"

@implementation MapOverlayView

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)ctx
{
    
    NSLog(@" >>>> %f",zoomScale);
    
    UIImage *image          = [[UIImage imageNamed:@"3.png"] retain];
    CGImageRef imageReference = image.CGImage;
    
    //Loading and setting the image
    MKMapRect theMapRect    = [self.overlay boundingMapRect];
    CGRect theRect           = [self rectForMapRect:theMapRect];

    
    // We need to flip and reposition the image here
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextTranslateCTM(ctx, 0.0, -theRect.size.height);
 
    //drawing the image to the context
    CGContextDrawImage(ctx, theRect, imageReference);
    
    [image release];     
}


@end
