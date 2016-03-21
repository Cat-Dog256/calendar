//
//  LCCalendarModel.h
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCalendarModel : NSObject
@property (nonatomic , strong) NSDate *monthDate;
@property (nonatomic , assign) NSInteger month;
@property (nonatomic , copy) NSAttributedString *dayString;
@property (nonatomic , assign) BOOL dateSelected;
@end
