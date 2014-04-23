//
//  iCodeBlogAnnotationView.m
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iCodeBlogAnnotationView.h"

@implementation iCodeBlogAnnotationView

@synthesize imageView;

#define kHeight 40
#define kWidth  37
#define kBorder 2

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	iCodeBlogAnnotation* myAnnotation = (iCodeBlogAnnotation*)annotation;
	
	if([myAnnotation annotationType] == iCodeBlogAnnotationTypeApple)
	{
		self = [super initWithAnnotation:myAnnotation reuseIdentifier:reuseIdentifier];
		self.frame = CGRectMake(0, 0, kWidth, kHeight);
		self.backgroundColor = [UIColor clearColor];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppleMarker.png"]];
		imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
		[self addSubview:imageView];
	}
	
	else if([myAnnotation annotationType] == iCodeBlogAnnotationTypeEDU)
	{
		self = [super initWithAnnotation:myAnnotation reuseIdentifier:reuseIdentifier];
		self.frame = CGRectMake(0, 0, kWidth, kHeight);
		self.backgroundColor = [UIColor clearColor];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SchoolMarker.png"]];
		imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
		[self addSubview:imageView];
	}
	
	else if([myAnnotation annotationType] == iCodeBlogAnnotationTypeTaco)
	{
		self = [super initWithAnnotation:myAnnotation reuseIdentifier:reuseIdentifier];
		self.frame = CGRectMake(0, 0, kWidth, kHeight);
		self.backgroundColor = [UIColor clearColor];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TacosMarker.png"]];
		imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
		[self addSubview:imageView];
	}
	
	[imageView setContentMode:UIViewContentModeScaleAspectFill];
	
	return self;
}

@end
