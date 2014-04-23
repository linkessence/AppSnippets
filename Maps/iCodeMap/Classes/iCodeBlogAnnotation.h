//
//  iCodeBlogAnnotation.h
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
	iCodeBlogAnnotationTypeApple = 0,
	iCodeBlogAnnotationTypeEDU = 1,
	iCodeBlogAnnotationTypeTaco = 2
} iCodeMapAnnotationType;

@interface iCodeBlogAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	iCodeMapAnnotationType annotationType;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic) iCodeMapAnnotationType annotationType;

@end
