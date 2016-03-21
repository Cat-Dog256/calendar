//
//  LCCalendarView.h
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCalendarView : UIView
@property (nonatomic , assign) CGFloat calendarViewY;
/**返回选择的时间段**/
- (void)setSelectedBlock:(void (^)(NSDate *startDate, NSDate *endDate))selectedBlock;
@end
