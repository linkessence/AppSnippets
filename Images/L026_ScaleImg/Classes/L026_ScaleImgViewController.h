//
//  L026_ScaleImgViewController.h
//  L026_ScaleImg
//
//  Created by jiaqiu on 11-7-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface L026_ScaleImgViewController : UIViewController {

	
	IBOutlet UIImageView * imageView;
	
	CGFloat lastDistance;
	
	CGFloat imgStartWidth;
	CGFloat imgStartHeight;
	
	
}

@end

