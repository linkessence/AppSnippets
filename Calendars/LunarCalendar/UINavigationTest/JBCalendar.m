//
//  JBCalendar.m
//  CalendarTest
//
//  Created by mac on 13-8-29.
//  Copyright (c) 2013年 caobo. All rights reserved.
//

#import "JBCalendar.h"

@implementation JBCalendar

@synthesize day,year,month;


- (NSDate *)nsDate
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
@end
