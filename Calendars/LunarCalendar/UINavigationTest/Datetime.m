//
//  Datetime.m
//  CalendarTest
//
//  Created by mac on 13-8-27.
//  Copyright (c) 2013年 caobo. All rights reserved.
//

#import "Datetime.h"
#import "LunarCalendar.h"
#import "JBCalendar.h"
@implementation Datetime
//所有年列表
+(NSArray *)GetAllYearArray{
    NSMutableArray * monthArray = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 1901; i<2050; i++) {
        NSString * days = [[NSString alloc]initWithFormat:@"%d",i];
        [monthArray addObject:days];
    }
    return monthArray;
}

//所有月列表
+(NSArray *)GetAllMonthArray{
    NSMutableArray * monthArray = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 1; i<13; i++) {
        NSString * days = [[NSString alloc]initWithFormat:@"%d",i];
        [monthArray addObject:days];
    }
    return monthArray;
}





//以YYYY.MM.dd格式输出年月日
+(NSString*)getDateTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}



//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
     NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

//以YYYY年MMdd格式输出此时的农历年月日
+(NSString*)GetLunarDateTime{
    JBCalendar* date = [[[JBCalendar alloc]init]autorelease];
    date.year = [[self GetYear] intValue],date.month =[[self GetMonth] intValue],date.day = [[self GetDay] intValue];
    LunarCalendar *lunarCalendar = [[[date nsDate] chineseCalendarDate]autorelease];
    NSString * lunar = [[NSString alloc]initWithFormat:
                           @"%@%@年%@%@",lunarCalendar.YearHeavenlyStem,lunarCalendar.YearEarthlyBranch,lunarCalendar.MonthLunar,lunarCalendar.DayLunar];
    return lunar;
}

//获取指定年份指定月份的星期排列表
+(NSArray *)GetDayArrayByYear:(int) year andMonth:(int) month{
    NSMutableArray * dayArray = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 0; i< 42; i++) {
        if (i < [self GetTheWeekOfDayByYera:year andByMonth:month]-1) {
            [dayArray addObject:@" "];
        }else if ((i>[self GetTheWeekOfDayByYera:year andByMonth:month]-1)&&(i<[self GetTheWeekOfDayByYera:year andByMonth:month]+[self GetNumberOfDayByYera:year andByMonth:month])){
            NSString * days;
            if((i - [self GetTheWeekOfDayByYera:year andByMonth:month] +1)< 10)
                days = [NSString stringWithFormat:@"  %d",i-[self GetTheWeekOfDayByYera:year andByMonth:month]+1];
            else days = [NSString stringWithFormat:@"%d",i-[self GetTheWeekOfDayByYera:year andByMonth:month]+1];
            [dayArray addObject:days];
        }else {
            [dayArray addObject:@" "];
        }
    }
    return dayArray;
}


//获取指定年份指定月份的星期排列表(农历)
+(NSArray *)GetLunarDayArrayByYear:(int) year andMonth:(int) month{
    NSMutableArray * dayArray = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 0; i< 42; i++) {
        if (i < [self GetTheWeekOfDayByYera:year andByMonth:month]-1) {
            [dayArray addObject:@" "];
        }else if ((i>[self GetTheWeekOfDayByYera:year andByMonth:month]-1)&&(i<[self GetTheWeekOfDayByYera:year andByMonth:month]+[self GetNumberOfDayByYera:year andByMonth:month])){
            NSString * days = [self GetLunarDayByYear:year andMonth:month andDay:(i-[self GetTheWeekOfDayByYera:year andByMonth:month]+1)];
            [dayArray addObject:days];
        }else {
            [dayArray addObject:@" "];
        }
    }
    return dayArray;
}

//获取某年某月某日的对应农历日
+(NSString *)GetLunarDayByYear:(int) year
                      andMonth:(int) month
                        andDay:(int) day{
    JBCalendar* date = [[[JBCalendar alloc]init]autorelease];
    date.year = year,date.month = month,date.day = day;
    LunarCalendar *lunarCalendar = [[[date nsDate] chineseCalendarDate]autorelease];
    NSString * lunarday = [[NSString alloc]initWithString:lunarCalendar.DayLunar];
    return lunarday;
}



//计算year年month月第一天是星期几，周日则为0
+(int)GetTheWeekOfDayByYera:(int)year
                 andByMonth:(int)month{
    int numWeek = ((year-1)+ (year-1)/4-(year-1)/100+(year-1)/400+1)%7;//numWeek为years年的第一天是星期几
    //NSLog(@"%d",numWeek);
    int ar[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    int numdays = (((year/4==0&&year/100!=0)||(year/400==0))&&(month>2))?(ar[month-1]+1):(ar[month-1]);//numdays为month月years年的第一天是这一年的第几天
    //NSLog(@"%d",numdays);
    int dayweek = (numdays%7 + numWeek)%7;//month月第一天是星期几，周日则为0
    //NSLog(@"%d",dayweek);
    return dayweek;
}

//判断year年month月有多少天
+(int)GetNumberOfDayByYera:(int)year
                andByMonth:(int)month{
    int nummonth = 0;
    //判断month月有多少天
    if ((month == 1)|| (month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        nummonth = 31;
    else if ((month == 4)|| (month == 6)||(month == 9)||(month == 11))
        nummonth = 30;
    else if (((year/4==0&&year/100!=0)||(year/400==0))&&(month>2))
        nummonth = 29;
    else nummonth = 28;
    return nummonth;
}



+(NSString *)GetYear{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetMonth{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetDay{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetHour{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetMinute{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetSecond{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"ss"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

@end
