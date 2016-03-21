//
//  LCCalendarModel.m
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCCalendarModel.h"
#import "NSDate+LCCalendar.h"
#import <UIKit/UIKit.h>
@implementation LCCalendarModel
- (NSString *)description{
    return [NSString stringWithFormat:@"%@---%@",_monthDate,_dayString];
}
- (void)setMonthDate:(NSDate *)monthDate{
    _monthDate = monthDate;
    UIColor *stringColor = nil;
    if ([[monthDate YMDComponents] isEqual:[[NSDate date] YMDComponents]]) {
        stringColor = [UIColor blueColor];
    }else if ([monthDate YMDComponents].month == self.month) {
        stringColor = [UIColor blackColor];
    }else{
        stringColor = [UIColor lightGrayColor];
    }
    
    NSAttributedString *attString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",(long)[_monthDate YMDComponents].day] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16] , NSForegroundColorAttributeName : stringColor}];
    _dayString = attString;
}
@end
