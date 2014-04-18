//
//  ViewController.m
//  DateModel
//
//  Created by mac on 3/11/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    
    
    [super viewDidLoad];
    beginDateLabel.text = [self dateToStringDate:[NSDate date]];
    endDateLabel.text = [self dateToStringDate:[NSDate date]];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)beginTimeControl:(id)sender{
    
    if (!beginDateButton.selected) {
        beginDateButton.selected = YES;
        datePicker.hidden = NO;
        datePicker.date = [self dateFromString:beginDateLabel.text];
        
        tooBar.hidden = NO;
    }else{
        [self deletedatePicker:nil];
    }
    
}

- (IBAction)endTimeControl:(id)sender{
    
    if (!endDateButton.selected) {
        endDateButton.selected = YES;
        datePicker.hidden = NO;
        datePicker.date = [self dateFromString:endDateLabel.text];
        tooBar.hidden = NO;
    }else{
        [self deletedatePicker:nil];
    }
    
}

- (IBAction)deletedatePicker:(id)sender{
    
    if (endDateButton.selected) {
        endDateLabel.text = [self dateToStringDate:datePicker.date];
        endDateButton.selected = NO;
    }
    if (beginDateButton.selected) {
        beginDateLabel.text = [self dateToStringDate:datePicker.date];
        beginDateButton.selected = NO;
    }
    
    datePicker.hidden = YES;
    tooBar.hidden = YES;
}

- (IBAction)countDay:(id)sender{
    NSDate *beginDate = [self dateFromString:beginDateLabel.text];
    NSDate *endDate = [self dateFromString:endDateLabel.text];
    NSDate *earlyDate = [beginDate earlierDate:endDate];
    
    if ([earlyDate isEqualToDate:endDate] && ![earlyDate isEqualToDate:beginDate]) {
        
        [self alterMessage:@"开始时间不得晚于结束时间"];
        return;
        
    }
    
    NSDateComponents *beginComponets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:beginDate];
    int beginWeekDay = [beginComponets weekday];
    
    NSDateComponents *endComponets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:endDate];
    int endWeekDay = [endComponets weekday];
    
    if (beginWeekDay == 1 || beginWeekDay == 7 || endWeekDay == 1 || endWeekDay == 7) {
        
        [self alterMessage:@"结束或开始时间不得为周末"];
        return;
        
    }
    
    NSTimeInterval time = [endDate timeIntervalSinceDate:beginDate];

    float oneWeekDay = 7 - beginWeekDay;

    float allDay = time / (24 * 60 * 60);

    float day = 0.0;

    if(allDay > oneWeekDay + 2){
        float otherDay = allDay - (oneWeekDay + 2);
        
        float ResidualDay = otherDay - ((int)otherDay / 7) * 2;
        
        day = ResidualDay + oneWeekDay;
    }else{
        day = endWeekDay - beginWeekDay;
    }
    

    computationDayLabel.text = [NSString stringWithFormat:@"%d",(int)day];
}

- (void)alterMessage:(NSString *)messageString{

    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [al show];
}

#pragma mark- ----------ComputationTime

- (NSString *)dateToStringDate:(NSDate *)Date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [dateFormatter stringFromDate:Date];
    destDateString = [destDateString substringToIndex:10];
    
    return destDateString;
}

- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[formatter dateFromString:dateString];
    
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date1 timeIntervalSinceReferenceDate] + 8*3600)];
    return newDate;
}


@end
