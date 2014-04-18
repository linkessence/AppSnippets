//
//  ViewController.h
//  DateModel
//
//  Created by mac on 3/11/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIButton *beginDateButton;
    IBOutlet UIButton *endDateButton;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIToolbar *tooBar;
    IBOutlet UIBarButtonItem *barButtonItem;
    IBOutlet UILabel *beginDateLabel;
    IBOutlet UILabel *endDateLabel;
    IBOutlet UIButton *computationDayButton;
    IBOutlet UILabel *computationDayLabel;
}


@end
