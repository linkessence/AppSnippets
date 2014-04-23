//
//  iCodeBlogAnnotationView.h
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "iCodeBlogAnnotation.h"

@interface iCodeBlogAnnotationView : MKAnnotationView 
{
	UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

@end
