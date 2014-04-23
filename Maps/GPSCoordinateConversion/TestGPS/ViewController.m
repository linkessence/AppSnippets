//
//  ViewController.m
//  TestGPS
//
//  Created by Lucky Ji on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize lat;
@synthesize llong;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    m_sqlite = [[CSqlite alloc]init];
    [m_sqlite openSqlite];
    self.m_map.showsUserLocation = YES;//显示ios自带的我的位置显示
    
}

- (void)viewDidUnload
{
    [self setLat:nil];
    [self setLlong:nil];
    [self setOffLat:nil];
    [self setOffLog:nil];
    [self setM_map:nil];
    [self setM_locationName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)OpenGPS:(id)sender {
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    
    NSLog(@"GPS 启动");
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation 
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    lat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    llong.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    
    mylocation = [self zzTransGPS:mylocation];///火星GPS
    self.offLat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    self.offLog.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    
    //显示火星坐标
    [self SetMapPoint:mylocation];
    
    /////////获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
    {
        if (placemarks.count >0   )
        {
            CLPlacemark * plmark = [placemarks objectAtIndex:0];
            
            NSString * country = plmark.country;
            NSString * city    = plmark.locality;
            
            
            NSLog(@"%@-%@-%@",country,city,plmark.name);
            self.m_locationName.text =plmark.name;
        }
        
        NSLog(@"%@",placemarks);
        
    }];
    
    //[geocoder release];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    NSLog(sql);
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
    
    
}

-(void)SetMapPoint:(CLLocationCoordinate2D)myLocation
{

    POI* m_poi = [[POI alloc]initWithCoords:myLocation];
    
    [self.m_map addAnnotation:m_poi];
    
    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
    theRegion.center=myLocation;
    [self.m_map setZoomEnabled:YES];
    [self.m_map setScrollEnabled:YES];
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
    [self.m_map setRegion:theRegion animated:YES];
}
@end


@implementation POI

@synthesize coordinate,subtitle,title;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
    self = [super init];
    
    if (self != nil) {
        
        coordinate = coords;
        
    }
    
    return self;
    
}

//- (void) dealloc
//
//{
//    [title release];
//    [subtitle release];
//    [super dealloc];
//}

@end
