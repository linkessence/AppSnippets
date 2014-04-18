//
//  PWSCustomViewController.m
//  PWSCalendar
//
//  Created by Sylar on 3/20/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
////////////////////////////////////////////////////////////
#import "PWSCustomViewController.h"
#import "PWSCalendarView.h"
#import "PWSCalendarViewController.h"
////////////////////////////////////////////////////////////
@interface PWSCustomViewController ()
<PWSCalendarDelegate>
{
    UIView* m_view_bottom;
}
@end
////////////////////////////////////////////////////////////
@implementation PWSCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self SetInitialValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) SetInitialValue
{
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    PWSCalendarView* view = [[PWSCalendarView alloc] initWithFrame:CGRectMake(0, 50, kSCREEN_WIDTH, 500) CalendarType:en_calendar_type_month];
    
    // custom view
    UIImage* img = [UIImage imageNamed:@"img1"];
    UIImageView* imv = [[UIImageView alloc] initWithImage:img];
    view.headType = en_calendar_head_type_custom;
    view.customTimeView = imv;
    
    
    [self.view addSubview:view];
    [view setDelegate:self];
    
    
    // bottom view
    m_view_bottom = [[UIView alloc] init];
    [m_view_bottom setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    [m_view_bottom setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:m_view_bottom];
    
    // back button
    UIButton* back = [PWSCalendarViewController GetButtonWithTitle:@"back"];
    [back setFrame:CGRectMake(0, 5, 100, 40)];
    [back addTarget:self action:@selector(BtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

// delegate
- (void) PWSCalendar:(PWSCalendarView*)_calendar didSelecteDate:(NSDate*)_date
{
    NSLog(@"select = %@", _date);
}

- (void) PWSCalendar:(PWSCalendarView*)_calendar didChangeViewHeight:(CGFloat)_height
{
    [m_view_bottom setFrame:CGRectMake(0, _height+50, kSCREEN_WIDTH, 30)];
}

- (void) BtnBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
