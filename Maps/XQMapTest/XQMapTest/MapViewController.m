//
//  ViewController.m
//  MapOverlay
//
//  Created by Raphael Petegrosso on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapOverlay.h"
#import "MapOverlayView.h"

@implementation MapViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Centering map
    CLLocationCoordinate2D coord1 = {
		48.85855,2.2945
	};
	
	MKCoordinateSpan span = {.latitudeDelta = 0.002, .longitudeDelta = 0.002};
	MKCoordinateRegion region = {coord1, span};
	[_mapView setRegion:region animated:YES];
    
    //Adding our overlay to the map
    MapOverlay * mapOverlay = [[MapOverlay alloc] init];
    [_mapView addOverlay:mapOverlay];
    [mapOverlay release];
    
}


- (void)viewDidUnload
{
    self.mapView.delegate = nil;

    self.mapView = nil;
    [super viewDidUnload];
}

-(void)dealloc {
    self.mapView.delegate = nil;
    self.mapView = nil;
    [super dealloc];
}

//delegate fired bby mapview requesting a MKOverlayView for each MapOverlay added
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {

    MapOverlay *mapOverlay = (MapOverlay *)overlay;    
    MapOverlayView *mapOverlayView = [[[MapOverlayView alloc] initWithOverlay:mapOverlay] autorelease];
    
    return mapOverlayView;
}

@end
