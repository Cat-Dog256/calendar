//
//  ViewController.m
//  日历
//
//  Created by 李策 on 16/3/16.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+LCCalendar.h"
#import "LCMakeCalendarArray.h"
#import "LCCalendarView.h"
@interface ViewController ()
@property (nonatomic , strong) NSDate *myDate;
@end

@implementation ViewController
- (NSDate *)myDate{
    if (!_myDate) {
        _myDate = [NSDate date];
    }
    return _myDate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    LCCalendarView *calendarView = [[LCCalendarView alloc]init];
    calendarView.calendarViewY = 100;
    [calendarView setSelectedBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"%@ -- %@",startDate,endDate);
    }];
    
    [self.view addSubview:calendarView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
