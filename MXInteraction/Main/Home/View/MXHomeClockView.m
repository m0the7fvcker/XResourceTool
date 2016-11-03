//
//  MXHomeClockView.m
//  MXInteraction
//
//  Created by maRk on 16/10/17.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeClockView.h"

@interface MXHomeClockView()

@property (nonatomic, copy) NSString *date;
@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, weak) UILabel *monthLabel;
@property (nonatomic, weak) UILabel *weekdayLabel;

@end

@implementation MXHomeClockView

- (instancetype)initWithFrame:(CGRect)frame andDateString:(NSString *)date
{
    if (self = [super initWithFrame:frame]) {
        self.date = date;
        [self initUI];
        [self initConstraint];
        [self handleDateString];
    }
    return self;
}

- (void)initUI
{
    UILabel *dayLabel = [[UILabel alloc] init];
    dayLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:53];
    dayLabel.textColor = [UIColor mx_colorWithHexString:@"666666"];

    dayLabel.textAlignment = NSTextAlignmentCenter;
//    dayLabel.backgroundColor = [UIColor mx_randomColor];
    self.dayLabel = dayLabel;
    [self addSubview:dayLabel];
    
    UILabel *monthLabel = [[UILabel alloc] init];
    
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.textColor = [UIColor mx_colorWithHexString:@"666666"];
//    monthLabel.backgroundColor = [UIColor mx_randomColor];
    self.monthLabel = monthLabel;
    [self addSubview:monthLabel];
    
    UILabel *weekdayLabel = [[UILabel alloc] init];
    
    weekdayLabel.textAlignment = NSTextAlignmentCenter;
    weekdayLabel.textColor = [UIColor mx_colorWithHexString:@"666666"];
//    weekdayLabel.backgroundColor = [UIColor redColor];
    self.weekdayLabel = weekdayLabel;
    [self addSubview:weekdayLabel];
    
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(-10);
        make.bottom.equalTo(weakSelf).offset(10);
        make.left.equalTo(weakSelf);
        make.width.equalTo(@(weakSelf.width / 2));
    }];
    
    [self.weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.dayLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@(weakSelf.height / 2));
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.dayLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@(weakSelf.height / 2));
    }];
}

- (void)handleDateString
{
    NSString *day = [self.date substringToIndex:2];
    
    NSString *month = [self.date substringFromIndex:3];
    
    self.dayLabel.text = day;
    self.monthLabel.text = month;
    self.weekdayLabel.text = [self getChineseWeekday];
}

- (NSString *)getChineseWeekday
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    // 年月日获得
    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitWeekday ) fromDate:date];
    
    NSInteger weekday = [comps weekday];
    NSString *chineseWeekdayName = @"";
    switch (weekday) {
        case 1:
            chineseWeekdayName = @"星期日";
            break;
        case 2:
            chineseWeekdayName = @"星期一";
            break;
        case 3:
            chineseWeekdayName = @"星期二";
            break;
        case 4:
            chineseWeekdayName = @"星期三";
            break;
        case 5:
            chineseWeekdayName = @"星期四";
            break;
        case 6:
            chineseWeekdayName = @"星期五";
            break;
        case 7:
            chineseWeekdayName = @"星期六";
            break;
        default:
            break;
    }
    calendar = nil;
    comps = nil;
    
    return chineseWeekdayName;
}
@end
