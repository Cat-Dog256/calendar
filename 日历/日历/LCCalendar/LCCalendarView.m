//
//  LCCalendarView.m
//  日历
//
//  Created by 李策 on 16/3/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCCalendarView.h"
#import "LCCalendarCell.h"
#import "LCMakeCalendarArray.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface LCCalendarView ()<UICollectionViewDataSource , UICollectionViewDelegate>
{   CGFloat margin;
    CGFloat itemWH;
    int count;
    NSDate *startDate;
    NSDate *endDate;
    LCMakeCalendarArray *managerArray;
    BOOL startOrEnd;
}
@property (nonatomic , copy) void(^selectedBlock)(NSDate *startDate,NSDate *endDate);
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) UICollectionView *myCollectionView;
@property (nonatomic , strong) UIView *dateView;
@property (nonatomic , strong) UIView *weekdaysView;
@property (nonatomic , strong) UILabel *YMLabel;
@property (nonatomic , strong) NSDateComponents *component;
@end

@implementation LCCalendarView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        margin = SCREEN_WIDTH/2 - 280/2;
        itemWH = 40;
        count = 0;
        managerArray = [[LCMakeCalendarArray alloc]init];
        [self createUI];
        [self.dataArray addObjectsFromArray:[managerArray getCurrentMonthViewDaysArray:[NSDate date]]];
        self.component = [[NSDate date] YMDComponents];
        
        [self addSubview:self.myCollectionView];


        UISwipeGestureRecognizer *recognizer;
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0,self.calendarViewY, SCREEN_WIDTH,44 + 20 + itemWH * 6);
}

//手势操作
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self addCount];
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        [self subtraction];
        }
    
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UILabel *)YMLabel{
    if (!_YMLabel) {
        _YMLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 0, 100, 44)];
        _YMLabel.backgroundColor = [UIColor whiteColor];
        _YMLabel.textAlignment = NSTextAlignmentCenter;
        [self.dateView addSubview:_YMLabel];
    }
    return _YMLabel;
}
-(void)setComponent:(NSDateComponents *)component{
    _component = component;
    NSString *monthString = [NSString stringWithFormat:@"%.2ld/%ld",(long)component.month,(long)component.year];
    self.YMLabel.text = monthString;
}
- (UIView *)dateView{
    if (!_dateView) {
        _dateView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 44)];
        _dateView.backgroundColor = [UIColor clearColor];
        [self addSubview:_dateView];
    }
    return _dateView;
}
- (UIView *)weekdaysView{
    if (!_weekdaysView) {
        _weekdaysView = [[UIView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 20)];
        _weekdaysView.backgroundColor = [UIColor clearColor];
        NSArray *array = @[@"Sun.",
                           @"Mon.",
                           @"Tue.",
                           @"Wed.",
                           @"Thu.",
                           @"Fri.",
                           @"Sat."];
        for (int i = 0; i < 7; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(margin + itemWH * i, 0, itemWH, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text =array[i];
            [_weekdaysView addSubview:label];
        }
        [self addSubview:_weekdaysView];
    }
    return _weekdaysView;
}
- (void)createUI{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.YMLabel.frame) - 44, 0, 44, 44)];
    [leftButton setImage:[UIImage imageNamed:@"Calendar-previousMonth@2x"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(subtraction) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:leftButton];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.YMLabel.frame), 0, 44, 44)];
    [rightButton setImage:[UIImage imageNamed:@"Calendar-nextMonth@2x"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addCount) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:rightButton];
    
}
- (void)addCount{
    count++;
    [self changeDataArray];
}
- (void)subtraction{
    count--;
    [self changeDataArray];
   }
- (void)changeDataArray{
    [self.dataArray removeAllObjects];
    NSDate *someDate = [[NSDate date] dayInTheFollowingMonth:count];
    self.component = [someDate YMDComponents];
    [self.dataArray addObjectsFromArray:[managerArray getCurrentMonthViewDaysArray:someDate]];
    [self.myCollectionView reloadData];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        //第一步 在创建collectionview之前 先创建它的约束 layout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //设置collectionview的滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //实例化collectionview
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.weekdaysView.frame), SCREEN_WIDTH,itemWH * 6) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 0.0;//行间距(最小值)
        flowLayout.minimumInteritemSpacing = 0.0;//item间距(最小值)
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.delegate = self;
        
        _myCollectionView.dataSource = self;
        
        //在IOS6以后 UICollectionViewCell的创建 都在这里写了
        [_myCollectionView registerClass: [LCCalendarCell class]forCellWithReuseIdentifier:@"ID"];
        
    }
    return _myCollectionView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LCCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//设置每个Item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(itemWH, itemWH);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, margin, 0,margin);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (startOrEnd == NO) {
        [managerArray setStartDate:[self.dataArray[indexPath.row] monthDate]];
        
    }else{
        managerArray.endDate = [self.dataArray[indexPath.row] monthDate];
    }
    NSDate *date = [self.dataArray[indexPath.row] monthDate];
    startOrEnd = !startOrEnd;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[managerArray getCurrentMonthViewDaysArray:date]];
    [collectionView reloadData];
    
    
    self.selectedBlock(managerArray.startDate,managerArray.endDate);
}

@end
