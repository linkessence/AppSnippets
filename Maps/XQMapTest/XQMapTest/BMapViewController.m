//
//  MapOverlayViewController.m
//  XQTest
//
//  Created by xf.lai on 13-7-18.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import "BMapViewController.h"
//#import "XQImageOverlay.h"
//#import "XQImageOverlayView.h"

@interface BMapViewController ()

@end

@implementation BMapViewController

-(void)dealloc
{
    //_mapView.delegate = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
       [super viewDidLoad];
	  
    /*
     
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];     //创建MKMapView
    _mapView.delegate = self;
    [self.view addSubview:_mapView];

    CLLocationCoordinate2D coord1 = {
		30.646,104.081 //48.85855,2.2945
	};
	
	BMKCoordinateSpan span = {.latitudeDelta = 0.01, .longitudeDelta = 0.01};
	BMKCoordinateRegion region = {coord1, span};
	[_mapView setRegion:region animated:YES];

    
    //Adding our overlay to the map
    XQImageOverlay * mapOverlay = [[XQImageOverlay alloc] init];
    [_mapView addOverlay:mapOverlay];
    */
       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - map_delegate
//delegate fired bby mapview requesting a MKOverlayView for each MapOverlay added
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    
    XQImageOverlay *mapOverlay = (XQImageOverlay *)overlay;
    XQImageOverlayView *mapOverlayView = [[XQImageOverlayView alloc] initWithOverlay:mapOverlay];
    return mapOverlayView;
    
}
*/

@end
