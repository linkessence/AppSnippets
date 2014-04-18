//
//  JBCalendar.h
//  CalendarTest
//
//  Created by mac on 13-8-29.
//  Copyright (c) 2013年 caobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBCalendar : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
- (NSDate *)nsDate;

@end
