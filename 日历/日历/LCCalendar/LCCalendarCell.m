//
//  LCCalendarCell.m
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCCalendarCell.h"
#import "NSDate+LCCalendar.h"
@interface LCCalendarCell ()
@property (nonatomic , strong) UILabel *dateLabel;
@end

@implementation LCCalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backView.backgroundColor = [UIColor grayColor];
        self.selectedBackgroundView = backView;
        self.backgroundColor = [UIColor clearColor];
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_dateLabel];
    }
    return self;
}

- (void)setModel:(LCCalendarModel *)model{
    _model = model;
    self.selected = model.dateSelected;
    _dateLabel.attributedText = model.dayString;
}
@end
