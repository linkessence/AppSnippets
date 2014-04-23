




#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"

@protocol MapViewControllerDidSelectDelegate; 
@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView *_mapView;
    
    
    id<MapViewControllerDidSelectDelegate> delegate;
}
@property(nonatomic,retain)IBOutlet MKMapView *mapView;

@property(nonatomic,assign)id<MapViewControllerDidSelectDelegate> delegate;

- (void)resetAnnitations:(NSArray *)data;
@end

@protocol MapViewControllerDidSelectDelegate <NSObject>

@optional
- (void)customMKMapViewDidSelectedWithInfo:(id)info;

@end