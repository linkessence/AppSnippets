//
//  PWSCalendarView.h
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "PWSHelper.h"
@class PWSCalendarView;
/////////////////////////////////////////////////////////////////////////////////////////////
@protocol PWSCalendarDelegate <NSObject>

@optional
- (void) PWSCalendar:(PWSCalendarView*)_calendar didSelecteDate:(NSDate*)_date;

- (void) PWSCalendar:(PWSCalendarView*)_calendar didChangeViewHeight:(CGFloat)_height;

@end

/////////////////////////////////////////////////////////////////////////////////////////////
@interface PWSCalendarView : UIView

@property (nonatomic, strong) id<PWSCalendarDelegate> delegate;
@property (nonatomic, assign) enCalendarViewType      type;
@property (nonatomic, assign) enCalendarViewHeaderViewType headType;
@property (nonatomic, strong) UIView*                 customTimeView;
@property (nonatomic, strong) UIView*                 customDataView;

- (id) initWithFrame:(CGRect)frame CalendarType:(enCalendarViewType)pType;

- (float) GetCalendarViewHeight __deprecated;

@end
