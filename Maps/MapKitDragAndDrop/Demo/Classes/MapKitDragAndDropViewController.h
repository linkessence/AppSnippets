//
//  MapKitDragAndDropViewController.h
//  MapKitDragAndDrop
//
//  Created by digdog on 11/1/10.
//  Copyright 2010 Ching-Lan 'digdog' HUANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapKitDragAndDropViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end

