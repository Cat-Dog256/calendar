//
//  LCMakeCalendarArray.m
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCMakeCalendarArray.h"

@implementation LCMakeCalendarArray
- (instancetype)init{
    self = [super init];
    if (self) {
        self.startDate = [[NSDate date] dayInThePerviousDay:1];
        self.endDate = [[NSDate date] dayInTheFollowingDay:1];
    }
    return self;
}
- (NSArray *)getCurrentMonthViewDaysArray:(NSDate *)date{
   NSInteger numberWeeks = [date numberOFWeeksInCurrentMonth];
    NSInteger week = [date weekDayOfFirstDayInCurrentMonth];
    int perbiousDays = (int)week - 1;
    NSDate *firstDate = [date firstDayInCurrenMonth];
    NSDate *lastDate = [firstDate dayInThePerviousDay:perbiousDays];
    NSInteger monthCount = [date YMDComponents].month;
    NSMutableArray *temArray = [NSMutableArray array];
    
    for (int i = 0; i < numberWeeks * 7; i++) {
        LCCalendarModel *model= [[LCCalendarModel alloc]init];
        model.month = monthCount;
        model.monthDate = [lastDate dayInTheFollowingDay:i];
        model.dateSelected = [NSDate date:model.monthDate isBetweenDate:self.startDate andDate:self.endDate];
        [temArray addObject:model];
    }
    return temArray;
}
- (void)setStartDate:(NSDate *)startDate{
    _startDate = startDate;
    _endDate = startDate;
}
- (void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    if ([endDate compare:_startDate] == NSOrderedAscending){
        _endDate = _startDate;
        _startDate = endDate;
    }
}
@end
