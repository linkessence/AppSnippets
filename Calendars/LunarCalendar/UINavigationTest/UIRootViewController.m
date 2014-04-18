//
//  UIRootViewController.m
//  UINavigationTest
//
//  Created by mac on 13-9-2.
//  Copyright (c) 2013年 caobo. All rights reserved.
//

#import "UIRootViewController.h"
#import "Datetime.h"
@implementation UIRootViewController{
    NSArray * dayArray;
    NSArray * lunarDayArray;
    int strMonth;
    int strYear;
    bool timePacker;
    UIView * timePickerView;
}

@synthesize titleView,pickerView;

- (id)init
{
    self = [super init];
    if (self) {
        strYear = [[Datetime GetYear] intValue];
        strMonth = [[Datetime GetMonth] intValue];
        dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
        lunarDayArray = [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
        timePacker = YES;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [dayArray release];
    [lunarDayArray release];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self AddNavigationBarToRootView];
    [self AddWeekLableToCalendarWatch];
    [self AddDaybuttenToCalendarWatch];
    [self AddHandleSwipe];
    [self OtherTouchEvent];
}
//为view添加NavigationBar
-(void)AddNavigationBarToRootView{
    [self AddTimeLableToNavigationBar];
    [self AddLeftButtenToNavigationBar];
    [self AddRightButtenArrayToNavigationBar];
}
//为NavigationBar添加中间的时间标题
-(void)AddTimeLableToNavigationBar{
    UIButton * titleButten = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [titleButten addSubview:[self CalendarTitleLabel]];
    [titleButten addSubview:[self LunarCalendarTitleLabel]];
    [titleButten addTarget:self action:@selector(titleButtenAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButten;
}
//制作阳历lable
-(UILabel *)CalendarTitleLabel{
    UILabel* calendarTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,80, 24)]autorelease];
    calendarTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    calendarTitleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    //titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
    calendarTitleLabel.textColor = [UIColor whiteColor];
    if ((strYear == [[Datetime GetYear] intValue])&&(strMonth ==[[Datetime GetMonth] intValue])){
        calendarTitleLabel.text = [Datetime getDateTime];
    }else {
        if (strMonth < 10) {
            calendarTitleLabel.text = [NSString stringWithFormat:@"%d年  %d月",strYear,strMonth];
        }else calendarTitleLabel.text = [NSString stringWithFormat:@"%d年%d月",strYear,strMonth];
    }
    //设置标题
    
    //calendarTitleLabel.text = [Datetime getDateTime];  //设置标题
    calendarTitleLabel.hidden = NO;
    calendarTitleLabel.tag = 2001;
    calendarTitleLabel.adjustsFontSizeToFitWidth = YES;
    return calendarTitleLabel;
}
//制作阴历lable
-(UILabel *)LunarCalendarTitleLabel{
    UILabel* lunarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24 ,80, 20)];
    lunarTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    lunarTitleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    //titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
    lunarTitleLabel.textColor = [UIColor whiteColor];
    if ((strYear == [[Datetime GetYear] intValue])&&(strMonth ==[[Datetime GetMonth] intValue])){
        lunarTitleLabel.text = [Datetime GetLunarDateTime];
    }else lunarTitleLabel.hidden = NO;//设置标题
    lunarTitleLabel.tag = 2002;
    lunarTitleLabel.adjustsFontSizeToFitWidth = YES;
    return lunarTitleLabel;
}
//时间标题点击事件
-(void)titleButtenAction:(id)sender{
    if (timePacker == YES){
        timePacker = NO;
        [self AddTimePickerToCalendarWatch];
    }else {
        timePacker = YES;
        [self reMoveTimePickerToCalendarWatch];
    }
}
//为NavigationBar添加左边的设置按钮
-(void)AddLeftButtenToNavigationBar{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"设置"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(LeftButtenAction)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
}
//左边的设置按钮Action
-(void)LeftButtenAction{
    NSLog(@"设置");
}
//为NavigationBar添加右边的返回今天按钮和添加事件按钮
-(void)AddRightButtenArrayToNavigationBar{
    //返回今天butten
    UIBarButtonItem *todayButten = [[UIBarButtonItem alloc]
                                    initWithTitle:@"今天"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                     action:@selector(backTodayAction)];
    //添加事件butten
    UIBarButtonItem *eventAddButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                        target:self
                                        action:@selector(eventAddAction)];
    NSArray *buttonArray = [[NSArray alloc]
                            initWithObjects:eventAddButton,todayButten,
                             nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}
//返回今天按钮
-(void)backTodayAction{
    strYear = [[Datetime GetYear] intValue];
    strMonth = [[Datetime GetMonth] intValue];
    [self reloadDateForCalendarWatch];
}
//添加事件按钮
-(void)eventAddAction{
    NSLog(@"添加");
}
//添加时间选择器
-(void)AddTimePickerToCalendarWatch{
    timePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, -30,320, 600)];
    timePickerView.hidden = timePacker;
    timePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    timePickerView.tag = 1000;
    UIView *timePicker = [[[UIView alloc]init]autorelease];
    timePicker.frame = CGRectMake(80, 80, 173, 240);
    timePicker.backgroundColor = [UIColor greenColor];
    UILabel * lable = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 173, 40)]autorelease];
    lable.text = @"选择日期";
    lable.backgroundColor = [UIColor whiteColor];
    lable.textColor = [UIColor blackColor];
    
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 173, 100)];
    pickerView.delegate=self;  
    pickerView.showsSelectionIndicator=YES;
    
    UIButton * ensureButten = [[[UIButton alloc]initWithFrame:CGRectMake(0, 200, 80, 40)]autorelease];
    [ensureButten addTarget:self action:@selector(ensureButtenAction:) forControlEvents:UIControlEventTouchUpInside];
    [ensureButten setTitle: @"确定" forState:UIControlStateNormal];
    ensureButten.titleLabel.textColor = [UIColor blackColor];
    [ensureButten setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * backButten = [[[UIButton alloc]initWithFrame:CGRectMake(80, 200, 93, 40)]autorelease];
    [backButten setTitle:@"返回" forState:UIControlStateNormal];
    [backButten addTarget:self action:@selector(backButtenAction:) forControlEvents:UIControlEventTouchUpInside];
    backButten.titleLabel.textColor = [UIColor blackColor];
    [backButten setBackgroundColor:[UIColor whiteColor]];
    
    [timePicker addSubview:lable];
    [timePicker addSubview:ensureButten];
    [timePicker addSubview:backButten];
    [timePicker addSubview:pickerView];
    
    [timePickerView addSubview:timePicker];
    [self.view addSubview:timePickerView];
    [timePickerView release];
}
//时间选择器的确定和返回按钮
-(void)ensureButtenAction:(id)sender{
    NSInteger rowYear=[pickerView selectedRowInComponent:0];
    strYear=[[[Datetime GetAllYearArray] objectAtIndex:(int)rowYear] intValue];
    NSInteger rowMonth=[pickerView selectedRowInComponent:1];
    strMonth=[[[Datetime GetAllMonthArray] objectAtIndex:(int)rowMonth] intValue];
    //NSLog(@"%d年%d",strYear,strMonth);
    timePacker = YES;
    [self reMoveTimePickerToCalendarWatch];
    [self reloadDateForCalendarWatch];
}
-(void)backButtenAction:(id)sender{
    timePacker = YES;
    [self reMoveTimePickerToCalendarWatch];
}

//时间选择器的栏数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//为时间选择器添加数据源
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [[Datetime GetAllYearArray] count];
    }else {
        return [[Datetime GetAllMonthArray] count];
    }
}
//将数据源显示在view上
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [[Datetime GetAllYearArray] objectAtIndex:row];
    }else {
        return [[Datetime GetAllMonthArray] objectAtIndex:row];
    }
}
//两栏宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(component == 0)
        return (100);
    return 55;
}
//移除时间选择器
-(void)reMoveTimePickerToCalendarWatch{
    [[self.view viewWithTag:1000] removeFromSuperview];
}

//向日历中添加星期标号（周日到周六）
-(void)AddWeekLableToCalendarWatch{
    NSMutableArray* array = [[NSMutableArray alloc]initWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:array[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(3+i*47, -30, 30, 46);
        lable.adjustsFontSizeToFitWidth = YES;
        //textAlignment = UITextAlignmentCenter;
        [self.view addSubview:lable];
        [lable release];
    }
}

//向日历中添加指定月份的日历butten
-(void)AddDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[[UIButton alloc]init]autorelease];
        butten.frame = CGRectMake((i%7)*47, 5+(i/7)*80, 47, 80);
       
        if (([[Datetime GetDay] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth] intValue])&&(strYear == [[Datetime GetYear] intValue])) {
            butten.backgroundColor = [UIColor yellowColor];
        }
        
//        UIImage *bgImg1 = [UIImage imageNamed:@"Selected.png"];
//        UIImage *bgImg2 = [UIImage imageNamed:@"Unselected.png"];
//        [butten setImage:bgImg2 forState:UIControlStateNormal];
//        [butten setImage:bgImg1 forState:UIControlStateSelected];
        [butten setTag:i+301];
//        [butten addTarget:self action:@selector(buttenTouchDownAction:) forControlEvents:UIControlEventTouchDown];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        UILabel* lable = [[[UILabel alloc]init]autorelease];
        lable.text = [NSString stringWithString:dayArray[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(0, 0, 47, 60);
        lable.adjustsFontSizeToFitWidth = YES;
        UILabel* lurLable = [[[UILabel alloc]init]autorelease];
        lurLable.text = [NSString stringWithString:lunarDayArray[i]];
        lurLable.textColor = [UIColor blackColor];
        lurLable.backgroundColor = [UIColor clearColor];
        lurLable.frame = CGRectMake(0, 40, 47, 20);
        lurLable.adjustsFontSizeToFitWidth = YES;
        [butten addSubview:lable];
        [butten addSubview:lurLable];
        [self.view addSubview:butten];
    }
}
-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++) 
        [[self.view viewWithTag:301+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
}
-(void)buttenTouchUpInsideAction:(id)sender{
    NSInteger t = [sender tag]-301;
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
    NSLog(@"%d年%d月%@日",strYear,strMonth,dayArray[t]);
    NSLog(@"%@",lunarDayArray[t]);
}

//添加左右滑动手势
-(void)AddHandleSwipe{
    //声明和初始化手势识别器
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightHandleSwipe:)];
    //对手势识别器进行属性设定
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    //把手势识别器加到view中去
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
}
//左滑事件
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    //NSLog(@"%u",gestureRecognizer.direction);
    strMonth = strMonth+1;
    if(strMonth == 13){
        strYear++;strMonth = 1;
    }
    //NSLog(@"%d,%d",strYear,strMonth);
    [self reloadDateForCalendarWatch];
}
//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    //NSLog(@"%u",gestureRecognizer.direction);
    strMonth = strMonth-1;
    if(strMonth == 0){
        strYear--;strMonth = 12;
    }
    //NSLog(@"%d,%d",strYear,strMonth);
    [self reloadDateForCalendarWatch];
}
//在CalendarWatch中重新部署数据
-(void)reloadDateForCalendarWatch{
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
    [self reloadDaybuttenToCalendarWatch];
    [self AddNavigationBarToRootView];
}

//识别其他手势，预留接口
-(void)OtherTouchEvent{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    //UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    /* step2：对手势识别器进行属性设定 */
    [doubleTap setNumberOfTapsRequired:2];
    // 坑：twoFingerTap在模拟器上不灵敏，有时候会识别成singleTap
    [twoFingerTap setNumberOfTouchesRequired:2];
    /* step3：把手势识别器加到view中去 */
    [self.view addGestureRecognizer:singleTap];
    [self.view addGestureRecognizer:doubleTap];
    [self.view addGestureRecognizer:twoFingerTap];
    [self.view addGestureRecognizer:rotation];
    //[self.view addGestureRecognizer:pan];
    [self.view addGestureRecognizer:pinch];
    [self.view addGestureRecognizer:longPress];
    /* step4：出现冲突时，要设定优先识别顺序，目前只是doubleTap、swipe */
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//    [singleTap requireGestureRecognizerToFail:twoFingerTap];
//    [pan requireGestureRecognizerToFail:swipeRight];
//    [pan requireGestureRecognizerToFail:swipeLeft];
}
//实现处理扑捉到手势之后的动作
/* 识别单击 */
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
}
/* 识别双击 */
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
}
/* 识别两个手指击 */
- (void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecognizer {
}
/* 识别翻转 */
- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer {
}
/* 识别拖动 */
- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
}
/* 识别放大缩小 */
- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer {
}
/* 识别长按 */
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
}

@end
