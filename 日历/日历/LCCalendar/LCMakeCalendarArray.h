//
//  LCMakeCalendarArray.h
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+LCCalendar.h"
#import "LCCalendarModel.h"
@interface LCMakeCalendarArray : NSObject
@property (nonatomic , strong) NSDate *startDate;
@property (nonatomic , strong) NSDate *endDate;
 - (NSArray *)getCurrentMonthViewDaysArray:(NSDate *)date;
@end
