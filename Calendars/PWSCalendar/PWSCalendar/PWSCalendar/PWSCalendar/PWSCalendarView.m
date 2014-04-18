//
//  PWSCalendarView.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
#import "PWSCalendarView.h"
#import "PWSCalendarSegmentView.h"
#import "PWSCalendarViewCell.h"
//////////////////////////////////////////////////////////////////////////////
//const float PWSCalendarHeadTimeLabelHeight = 67;
//const float PWSCalendarHeadSegmentHeight = 25;
//const float PWSCalendarHeadSeperateLineHeight = 5;
//const float PWSCalendarHeadWeekdaysHeight = 25;


const float PWSCalendarTimeHeadViewHeight = 60;
//const float PWSCalendarDataHeadViewHeight = 60;
const float PWSCalendarSegmentHeight = 25;
const float PWSCalendarSeperateLineHeight= 5;
const float PWSCalendarWeekDaysHeight = 25;

extern NSString* PWSCalendarViewCellId;
const int   PWSCalendarViewNumber = 1000;
//////////////////////////////////////////////////////////////////////////////
@interface PWSCalendarView()
<PWSCalendarSegmentDelegate,
PWSCalendarDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate>
{
    // data
    NSDate*            m_current_date;
    int                m_current_page;
    
    // head view
    UIView*            m_view_head;
    UILabel*           m_label_time;       // the label
    UIView*            m_time_head_view;   // the time view
    UIView*            m_data_head_view;   // the data view
    PWSCalendarSegmentView*  m_segment;
    UIView*            m_view_weekdays;
    
    UICollectionView*  m_view_calendar;
}
@end
//////////////////////////////////////////////////////////////////////////////
@implementation PWSCalendarView

- (id) initWithFrame:(CGRect)frame
{
    id rt = [self initWithFrame:frame CalendarType:en_calendar_type_month];
    return rt;
}

- (id) initWithFrame:(CGRect)frame CalendarType:(enCalendarViewType)pType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.type = pType;
        self.headType = en_calendar_head_type_default;
        m_current_date = [NSDate date];
        [self SetInitialValue];
    }
    return self;
}

- (float) GetCalendarViewHeight
{
    PWSCalendarViewCell* the_cell = [[m_view_calendar visibleCells] lastObject];
    float rt = the_cell.getCalendarHeight;
    rt += [self GetHeaderViewHeight];
    return rt;
}

- (void) setHeadType:(enCalendarViewHeaderViewType)headType
{
    _headType = headType;
    if (headType == en_calendar_head_type_default)
    {
        // if set to default, remove the custom views
        if (_customDataView)
        {
            [_customDataView removeFromSuperview];
        }
        if (_customTimeView)
        {
            [_customTimeView removeFromSuperview];
        }
        
        // add the default views
        [self SetTimeHeadView];
        [self SetDataHeadView];
    }
}

- (void) setCustomTimeView:(UIView *)customTimeView
{
    _customTimeView = customTimeView;
    if (_headType == en_calendar_head_type_custom)
    {
        [m_time_head_view removeFromSuperview];
        m_time_head_view = customTimeView;
        [self addSubview:m_time_head_view];
        [self AutoLayoutCustomHeadView];
    }
}

- (void) setCustomDataView:(UIView *)customDataView
{
    _customDataView = customDataView;
    if (_headType == en_calendar_head_type_custom)
    {
        [m_data_head_view removeFromSuperview];
        m_data_head_view = customDataView;
        [self addSubview:customDataView];
        [self AutoLayoutCustomHeadView];
    }
}

- (void) AutoLayoutCustomHeadView
{
    float origin_y = 0;

    CGRect frame = m_time_head_view.frame;
    frame.origin.y = origin_y;
    [m_time_head_view setFrame:frame];
    origin_y += frame.size.height;
    
    frame = m_data_head_view.frame;
    frame.origin.y = origin_y;
    [m_data_head_view setFrame:frame];
    origin_y += frame.size.height;
    
    frame = m_view_calendar.frame;
    [m_view_calendar setFrame:CGRectMake(0, origin_y, self.frame.size.width, self.frame.size.height-origin_y)];
}

- (float) GetHeaderViewHeight
{
    float rt = [self GetDataHeadViewHeight] + [self GetTimeHeadViewHeight];
    return rt;
}

- (float) GetTimeHeadViewHeight
{
    float rt = 0;
    if (_headType == en_calendar_head_type_custom && _customTimeView)
    {
        rt = _customTimeView.frame.size.height;
    }
    else
    {
        rt = PWSCalendarTimeHeadViewHeight;
    }
    return rt;
}

- (float) GetDataHeadViewHeight
{
    float rt = 0;
    if (_headType == en_calendar_head_type_custom && _customDataView)
    {
        rt = _customDataView.frame.size.height;
    }
    else
    {
        rt = PWSCalendarSegmentHeight+PWSCalendarSeperateLineHeight+PWSCalendarWeekDaysHeight;
    }
    return rt;
}

- (void) SetInitialValue
{
    [self SetTimeHeadView];
    [self SetDataHeadView];
    [self SetCollectionView];
}

- (void) SetTimeHeadView
{
    if (m_time_head_view)
    {
        return;
    }
    m_time_head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self GetTimeHeadViewHeight])];
    [self addSubview:m_time_head_view];
    
    m_label_time = [[UILabel alloc] init];
    [m_label_time setFrame:m_time_head_view.bounds];
    [m_label_time setText:@"2014-2-29"];
    [m_label_time setTextAlignment:NSTextAlignmentCenter];
    [m_time_head_view addSubview:m_label_time];
}

- (void) SetDataHeadView
{
    if (m_data_head_view)
    {
        return;
    }
    float width = self.frame.size.width;
    float origin_x = 0;
    
    // the view
    m_data_head_view = [[UIView alloc] initWithFrame:CGRectMake(0, [self GetTimeHeadViewHeight], width, [self GetDataHeadViewHeight])];
    [self addSubview:m_data_head_view];
    
    // segment
    NSArray* items = [NSArray arrayWithObjects:[self GetSegmentItemWithTitle:@"TODAY"], [self GetSegmentItemWithTitle:@"WEEKLY"], [self GetSegmentItemWithTitle:@"MONTHLY"], nil];
    m_segment = [PWSCalendarSegmentView CreateWithItems:items Frame:CGRectMake(0, origin_x, width, PWSCalendarSegmentHeight)];
    [m_segment setP_delegate:self];
    [m_data_head_view addSubview:m_segment];
    
    // seperate line
    origin_x += PWSCalendarSegmentHeight;
    float edge = 10;
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(edge, origin_x, width-2*edge, 2)];
    [line.layer setCornerRadius:5];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [m_data_head_view addSubview:line];
    
    // weekdays
    origin_x += PWSCalendarSeperateLineHeight;
    NSArray* weekdays = [NSArray arrayWithObjects:@"SUN", @"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", nil];
    float day_width = width/7;
    for (int i=0; i<7; i++)
    {
        UILabel* each_day = [[UILabel alloc] init];
        [each_day setText:[weekdays objectAtIndex:i]];
        [each_day setTextAlignment:NSTextAlignmentCenter];
        CGRect each_day_frame = CGRectMake(i*day_width, origin_x, day_width, PWSCalendarWeekDaysHeight);
        [each_day setFrame:each_day_frame];
        [m_data_head_view addSubview:each_day];
    }
}

- (void) SetLabelDate:(NSDate*)_date
{
    NSDateFormatter* ff = [[NSDateFormatter alloc] init];
    [ff setDateFormat:@"yyyy-MM-dd"];
    NSString* date = [ff stringFromDate:_date];
    if (m_label_time)
    {
        [m_label_time setText:date];
    }
}

- (PWSCalendarSegmentItem*) GetSegmentItemWithTitle:(NSString*)pTitle
{
    UILabel* label = [[UILabel alloc] init];
    [label setText:pTitle];
    [label setTextAlignment:NSTextAlignmentCenter];
    PWSCalendarSegmentItem* rt = [PWSCalendarSegmentItem CreateWithImage:nil HighLightedImage:nil Label:label LabelColor:[UIColor blackColor] LabelHighlightedColor:kPWSDefaultColor];
    return rt;
}

- (void) SetCollectionView
{
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    [layout setItemSize:CGSizeMake(width, height-[self GetHeaderViewHeight])];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    m_view_calendar = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self GetHeaderViewHeight], width, height-[self GetHeaderViewHeight]) collectionViewLayout:layout];
    [m_view_calendar setShowsHorizontalScrollIndicator:NO];
    [m_view_calendar setDelegate:self];
    [m_view_calendar setDataSource:self];
    [m_view_calendar setBackgroundColor:[UIColor clearColor]];
    [self addSubview:m_view_calendar];
    m_view_calendar.pagingEnabled = YES;
    
    [m_view_calendar registerClass:[PWSCalendarViewCell class] forCellWithReuseIdentifier:PWSCalendarViewCellId.copy];
    
    m_current_page = PWSCalendarViewNumber/2;
    NSIndexPath* mid_index = [NSIndexPath indexPathForRow:m_current_page inSection:0];
    [m_view_calendar scrollToItemAtIndexPath:mid_index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self SetLabelDate:[NSDate date]];
}

// collection view delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return PWSCalendarViewNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PWSCalendarViewCell* cell = [m_view_calendar dequeueReusableCellWithReuseIdentifier:PWSCalendarViewCellId.copy forIndexPath:indexPath];
    
    NSDate* cell_date = m_current_date;
    
    if (indexPath.row != m_current_page)
    {
        if (self.type == en_calendar_type_month)
        {
            if (indexPath.row > m_current_page)
            {
                cell_date = [PWSHelper GetNextMonth:m_current_date];
            }
            else
            {
                cell_date = [PWSHelper GetPreviousMonth:m_current_date];
            }
        }
        else if (self.type == en_calendar_type_week)
        {
            if (indexPath.row > m_current_page)
            {
                cell_date = [PWSHelper GetNextWeek:m_current_date];
            }
            else
            {
                cell_date = [PWSHelper GetPreviousWeek:m_current_date];
            }
        }
    }
    [cell setDelegate:self];
    [cell SetWithDate:cell_date ShowType:self.type];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cell_width = collectionView.frame.size.width;
    int pos_x = collectionView.contentOffset.x;
    int index = (pos_x+20)/cell_width;
    
    if (m_current_page != index)
    {
        if (self.type == en_calendar_type_month)
        {
            if (m_current_page > index)
            {
                m_current_date = [PWSHelper GetPreviousMonth:m_current_date];
            }
            else if (m_current_page < index)
            {
                m_current_date = [PWSHelper GetNextMonth:m_current_date];
            }
            m_current_page = index;
        }
        else if (self.type == en_calendar_type_week)
        {
            if (m_current_page > index)
            {
                m_current_date = [PWSHelper GetPreviousWeek:m_current_date];
            }
            else if (m_current_page < index)
            {
                m_current_date = [PWSHelper GetNextWeek:m_current_date];
            }
            m_current_page = index;
        }
    }
    
    [self SetLabelDate:m_current_date];
    [self PWSCalendar:nil didChangeViewHeight:0];
}

- (void) ScrollToToday
{
    NSDate* today = [NSDate date];
    if (self.type == en_calendar_type_month)
    {
        // max scroll 2 page
        if (![PWSHelper CheckSameMonth:today AnotherMonth:m_current_date])
        {
            int scroll_pages = 0;
            NSComparisonResult result = [today compare:m_current_date];
            if (result == NSOrderedDescending)
            {
                if ([PWSHelper CheckThisMonth:m_current_date NextMonth:today])
                {
                    scroll_pages = 1;
                    m_current_date = [PWSHelper GetPreviousMonth:today];
                }
                else
                {
                    scroll_pages = 2;
                    m_current_date = [PWSHelper GetPreviousMonth:today];
                    m_current_date = [PWSHelper GetPreviousMonth:m_current_date];
                }
            }
            else if (result == NSOrderedAscending)
            {
                if ([PWSHelper CheckThisMonth:today NextMonth:m_current_date])
                {
                    scroll_pages = -1;
                    m_current_date = [PWSHelper GetNextMonth:today];
                }
                else
                {
                    scroll_pages = -2;
                    m_current_date = [PWSHelper GetNextMonth:today];
                    m_current_date = [PWSHelper GetNextMonth:m_current_date];
                }
            }
            
            NSIndexPath* indexpath = [NSIndexPath indexPathForRow:m_current_page+scroll_pages inSection:0];
            [m_view_calendar scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
    else if (self.type == en_calendar_type_week)
    {
        if (![PWSHelper CheckSameWeek:m_current_date AnotherWeek:today])
        {
            int scroll_pages = 0;
            NSComparisonResult result = [today compare:m_current_date];
            if (result == NSOrderedDescending)
            {
                if ([PWSHelper CheckThisWeek:m_current_date NextWeek:today])
                {
                    scroll_pages = 1;
                    m_current_date = [PWSHelper GetPreviousWeek:today];
                }
                else
                {
                    scroll_pages = 2;
                    m_current_date = [PWSHelper GetPreviousWeek:today];
                    m_current_date = [PWSHelper GetPreviousWeek:m_current_date];
                }
            }
            else if (result == NSOrderedAscending)
            {
                if ([PWSHelper CheckThisWeek:today NextWeek:m_current_date])
                {
                    scroll_pages = -1;
                    m_current_date = [PWSHelper GetNextWeek:today];
                }
                else
                {
                    scroll_pages = -2;
                    m_current_date = [PWSHelper GetNextWeek:today];
                    m_current_date = [PWSHelper GetNextWeek:m_current_date];
                }
            }
            
            NSIndexPath* indexpath = [NSIndexPath indexPathForRow:m_current_page+scroll_pages inSection:0];
            [m_view_calendar scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
}

// segment delegate
- (void) PWSCalendarSegment:(PWSCalendarSegmentView *)_segment didSelectedIndex:(NSInteger)_index
{
    if (_index == 1)
    {
        // week
        self.type = en_calendar_type_week;
        NSArray* cells = [m_view_calendar visibleCells];
        for (PWSCalendarViewCell* each_cell in cells)
        {
            each_cell.firstShow = YES;
            [each_cell setType:en_calendar_type_week];
        }
    }
    else if (_index == 2)
    {
        // month
        self.type = en_calendar_type_month;
        NSArray* cells = [m_view_calendar visibleCells];
        for (PWSCalendarViewCell* each_cell in cells)
        {
            each_cell.firstShow = YES;
            [each_cell setType:en_calendar_type_month];
        }
    }
    else if (_index == 0)
    {
        [self ScrollToToday];
    }
    
    [m_view_calendar reloadData];
}

// calendar delegate
- (void) PWSCalendar:(PWSCalendarView *)_calendar didSelecteDate:(NSDate *)_date
{
    m_current_date = _date;
    [self SetLabelDate:_date];
    if ([self.delegate respondsToSelector:@selector(PWSCalendar:didSelecteDate:)])
    {
        [self.delegate PWSCalendar:self didSelecteDate:_date];
    }
}

- (void) PWSCalendar:(PWSCalendarView *)_calendar didChangeViewHeight:(CGFloat)_height
{
    float height = [self GetCalendarViewHeight];
    
    // change calendar height
    float calendar_height = height-[self GetHeaderViewHeight];
    CGRect calendar_frame = m_view_calendar.frame;
    calendar_frame.size.height = calendar_height;
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)m_view_calendar.collectionViewLayout;
    CGSize flowlayout_size = layout.itemSize;
    flowlayout_size.height = calendar_height;
    layout.itemSize = flowlayout_size;
    [m_view_calendar setFrame:calendar_frame];
    
    // set self height
    CGRect frame_self = self.frame;
    frame_self.size.height = height;
    [self setFrame:frame_self];
    
    // callback delegate
    if ([self.delegate respondsToSelector:@selector(PWSCalendar:didChangeViewHeight:)])
    {
        [self.delegate PWSCalendar:self didChangeViewHeight:height];
    }
}
@end
