//
//  iCodeMapViewController.h
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "iCodeBlogAnnotation.h"
#import "iCodeBlogAnnotationView.h"

@interface iCodeMapViewController : UIViewController <MKMapViewDelegate>
{
	IBOutlet UITableView *tableview;
	IBOutlet MKMapView *mapView;
	IBOutlet UIImageView *shadowImage;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIImageView *shadowImage;

-(void)loadOurAnnotations;

@end

