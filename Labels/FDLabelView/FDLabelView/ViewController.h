//
//  ViewController.h
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDLabelView.h"

@interface ViewController : UIViewController{
    BOOL _debug;
}

@property(nonatomic, retain) FDLabelView* labelView;
@property(nonatomic, retain) FDLabelView* titleView;
@property(nonatomic, retain) FDLabelView* fillTextView;


@end
