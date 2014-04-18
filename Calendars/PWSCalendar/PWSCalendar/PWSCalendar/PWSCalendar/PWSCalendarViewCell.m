//
//  PWSCalendarViewCell.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////
#import "PWSCalendarViewCell.h"
#import "PWSCalendarViewFlowLayout.h"
#import "PWSCalendarDayCell.h"
#import "PWSCalendarView.h"
///////////////////////////////////////////////////////////////////////////
extern NSString* PWSCalendarDayCellId;
const NSString* PWSCalendarViewCellId = @"PWSCalendarViewCellId";
///////////////////////////////////////////////////////////////////////////
@interface PWSCalendarViewCell()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>
{
    NSCalendar*        m_calendar;
    UICollectionView*  m_collection_view;
    NSDate*            m_first_date;       // if week => select date
}
@end
///////////////////////////////////////////////////////////////////////////
@implementation PWSCalendarViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _firstShow = YES;
        self.type = en_calendar_type_month;
        m_calendar = [NSCalendar currentCalendar];
        m_first_date = [NSDate date];
        [self SetInitialValue];
    }
    return self;
}

- (void) SetInitialValue
{
    PWSCalendarViewFlowLayout* layout = [[PWSCalendarViewFlowLayout alloc] init];
    CGFloat itemWidth = floorf(CGRectGetWidth(self.bounds) / 7);
    layout.itemSize = CGSizeMake(itemWidth, itemWidth/2);
    
    m_collection_view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self.contentView addSubview:m_collection_view];
    
    [m_collection_view setBackgroundColor:[UIColor clearColor]];
    [m_collection_view setDelegate:self];
    [m_collection_view setDataSource:self];
    [m_collection_view setScrollEnabled:NO];
    
    [m_collection_view registerClass:[PWSCalendarDayCell class] forCellWithReuseIdentifier:PWSCalendarDayCellId.copy];
}

- (void) setType:(enCalendarViewType)type
{
    _type = type;
    [m_collection_view reloadData];
}

- (void) ResetSelfFrame
{
    CGRect collection_view_frame = m_collection_view.frame;
    collection_view_frame.size.height = self.calendarHeight;
    [m_collection_view setFrame:collection_view_frame];
    
    // change view height
    if (_firstShow)
    {
        if ([self.delegate respondsToSelector:@selector(PWSCalendar:didChangeViewHeight:)])
        {
            [self.delegate performSelector:@selector(PWSCalendar:didChangeViewHeight:) withObject:nil withObject:nil];
        }
        _firstShow = NO;
    }
}

- (void) SetWithDate:(NSDate*)pDate ShowType:(enCalendarViewType)pCalendarType
{
    if (pCalendarType == en_calendar_type_month)
    {
        m_first_date = [self GetFirstDayOfMonth:pDate];
    }
    else if (pCalendarType == en_calendar_type_week)
    {
        m_first_date = pDate;
    }
    
    self.type = pCalendarType;
}

// reference
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSInteger ordinalityOfFirstDay = [m_calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firstOfMonth];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;
    
    return [m_calendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

- (NSDate *)firstOfMonthForSection:(NSInteger)section
{
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;
    
    NSDate* rt = [m_calendar dateByAddingComponents:offset toDate:m_first_date options:0];
    return rt;
}

- (NSDate*) GetFirstDayOfMonth:(NSDate*)pDate
{
    NSDateComponents *components = [m_calendar components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:pDate];
    NSDate* rt = [m_calendar dateFromComponents:components];
    return rt;
}

// delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int rt = 0;
    CGFloat itemWidth = floorf(CGRectGetWidth(m_collection_view.bounds) / 7);
    CGFloat itemHeight = itemWidth/2;
    if (self.type == en_calendar_type_month)
    {
        NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:m_first_date];
        self.calendarHeight = itemHeight*rangeOfWeeks.length;
        rt = (rangeOfWeeks.length * 7);
    }
    else if (self.type == en_calendar_type_week)
    {
        self.calendarHeight = itemHeight;
        rt = 7;
    }

    [self ResetSelfFrame];
    return rt;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PWSCalendarDayCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PWSCalendarDayCellId.copy forIndexPath:indexPath];
    
    NSDate* cell_date = [self dateForCellAtIndexPath:indexPath];
    
    
    NSDateComponents *cellDateComponents = [m_calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:cell_date];
    NSDateComponents *firstOfMonthsComponents = [m_calendar components:NSMonthCalendarUnit fromDate:m_first_date];
    
    if (self.type == en_calendar_type_month)
    {
        if (cellDateComponents.month == firstOfMonthsComponents.month)
        {
            [cell SetDate:cell_date];
        }
        else
        {
            [cell SetDate:nil];
        }
    }
    else if (self.type == en_calendar_type_week)
    {
        if (1)
        {
            [cell SetDate:cell_date];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(PWSCalendar:didSelecteDate:)])
    {
        NSDate* date = [self dateForCellAtIndexPath:indexPath];
        [self.delegate performSelector:@selector(PWSCalendar:didSelecteDate:) withObject:nil withObject:date];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate* selected_date = [self dateForCellAtIndexPath:indexPath];
    BOOL rt = [PWSHelper CheckSameMonth:selected_date AnotherMonth:m_first_date];
    return rt;
}


#pragma mark - UICollectionViewFlowLayoutDelegate
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat itemWidth = floorf(CGRectGetWidth(m_collection_view.bounds) / 7);
//    
//    return CGSizeMake(itemWidth, itemWidth/2);
//}


@end
