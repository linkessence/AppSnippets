//
//  XQImageOverlay.m
//  XQMapTest
//
//  Created by xf.lai on 13-7-16.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import "XQImageOverlay.h"

@implementation XQImageOverlay

//-(CLLocationCoordinate2D)coordinate {
//    //Image center point
//    return CLLocationCoordinate2DMake(48.85883, 2.2945);
//}
//
//- (BMKMapRect)boundingMapRect
//{
//    //Latitue and longitude for each corner point
//    BMKMapPoint upperLeft   = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85995, 2.2933));
//    BMKMapPoint upperRight  = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85995, 2.2957));
//    BMKMapPoint bottomLeft  = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(48.85758, 2.2933));
//    
//    //Building a map rect that represents the image projection on the map
//    BMKMapRect bounds = BMKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));
//    
//    return bounds;
//}
-(CLLocationCoordinate2D)coordinate {
    //Image center point
    return CLLocationCoordinate2DMake(30.646,104.081);//(48.85883, 2.2945);
}

- (BMKMapRect)boundingMapRect
{
    //Latitue and longitude for each corner point
    BMKMapPoint upperLeft   = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(30.650, 104.078));//(48.85995, 2.2933));
    BMKMapPoint upperRight  = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(30.650, 104.084));//(48.85995, 2.2957));
    BMKMapPoint bottomLeft  = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(30.642, 104.078));//(48.85758, 2.2933));
    
    //Building a map rect that represents the image projection on the map
    BMKMapRect bounds = BMKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));
    
    return bounds;
}



@end
