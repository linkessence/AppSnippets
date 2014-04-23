//
//  MapOverlay.m
//  MapOverlay
//
//  Created by Raphael Petegrosso on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapOverlay.h"


@implementation MapOverlay

-(CLLocationCoordinate2D)coordinate {
    //Image center point
    return CLLocationCoordinate2DMake(48.85883, 2.2945);
}

- (MKMapRect)boundingMapRect
{
    //Latitue and longitude for each corner point
    MKMapPoint upperLeft   = MKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85995, 2.2933));
    MKMapPoint upperRight  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85995, 2.2957));
    MKMapPoint bottomLeft  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85758, 2.2933));
    
    //Building a map rect that represents the image projection on the map
    MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));

    return bounds;
}

-(void) dealloc {
    [super dealloc];
}

@end
