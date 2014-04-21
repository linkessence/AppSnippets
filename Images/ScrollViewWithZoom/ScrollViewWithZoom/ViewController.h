//
//  ViewController.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView      *scrollView;

@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;

@end
