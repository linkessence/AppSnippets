//
//  MapOverlay.h
//  iCardinal
//
//  Created by Edmar Miyake on 8/1/11.
//  Copyright 2011 I.ndigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapOverlay : NSObject <MKOverlay> {
    
}
- (MKMapRect)boundingMapRect;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end