//
//  PWSHelper.h
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//


#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kPWSDefaultColor [UIColor colorWithRed:132/255.9 green:157/255.9 blue:72/255.9 alpha:1]
////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSInteger, enCalendarViewType)
{
    en_calendar_type_week = 1,
    en_calendar_type_month = 2,
};
////////////////////////////////////////////////////////////////////
typedef  NS_ENUM(NSInteger, enCalendarViewHeaderViewType)
{
    en_calendar_head_type_default = 1,
    en_calendar_head_type_custom = 2,
};
////////////////////////////////////////////////////////////////////

@interface PWSHelper : NSObject

+ (UIColor*) GetRandomColor;

+ (NSDate*) GetNextMonth:(NSDate*)_date;

+ (NSDate*) GetPreviousMonth:(NSDate*)_date;

+ (NSDate*) GetNextWeek:(NSDate*)_date;

+ (NSDate*) GetPreviousWeek:(NSDate*)_date;

+ (BOOL) CheckSameDay:(NSDate*)_date1 AnotherDate:(NSDate*)_date2;

+ (BOOL) CheckThisMonth:(NSDate*)_thisMonth NextMonth:(NSDate*)_nextMonth;

+ (BOOL) CheckSameMonth:(NSDate*)_month1 AnotherMonth:(NSDate*)_month2;

+ (BOOL) CheckThisWeek:(NSDate*)_thisWeek NextWeek:(NSDate*)_nextWeek;

+ (BOOL) CheckSameWeek:(NSDate*)_week1 AnotherWeek:(NSDate*)_week2;


@end
