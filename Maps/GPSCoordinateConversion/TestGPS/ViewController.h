//
//  ViewController.h
//  TestGPS
//
//  Created by Lucky Ji on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import <MapKit/MapKit.h>

@interface POI : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *title;

-(id) initWithCoords:(CLLocationCoordinate2D) coords;

@end

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
}
- (IBAction)OpenGPS:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *llong;
@property (weak, nonatomic) IBOutlet UILabel *offLat;
@property (weak, nonatomic) IBOutlet UILabel *offLog;
@property (weak, nonatomic) IBOutlet MKMapView *m_map;
@property (weak, nonatomic) IBOutlet UILabel *m_locationName;

@end


