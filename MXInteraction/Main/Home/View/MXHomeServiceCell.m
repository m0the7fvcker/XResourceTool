//
//  MXHomeServiceCell.m
//  MXInteraction
//
//  Created by maRk on 16/8/23.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeServiceCell.h"
#import "MXHomeServiceBtn.h"

@interface MXHomeServiceCell()
@property (nonatomic, strong) NSArray <NSDictionary*> *dataArray;
@end

@implementation MXHomeServiceCell

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initData];
        [self initUI];
        [self initConstraint];
    }
    
    return self;
}

- (void)initData
{
    self.dataArray = @[@{@"title":@"物业服务",
                         @"subTitle":@"报修、投票、投诉等",
                         @"image":@"home_icon_service_1"},
                       @{@"title":@"呼叫电梯",
                         @"subTitle":@"预约电梯，懒人必备",
                         @"image":@"home_icon_service_2"}];
}

- (void)initUI
{
    CGFloat buttonHeight = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        buttonHeight = 150;
    }else {
        buttonHeight = 192;
    }
    // 左边按钮
    MXHomeServiceBtn *leftBtn = [[MXHomeServiceBtn alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width / 2, buttonHeight) index:0 title:self.dataArray[0][@"title"] subTitle:self.dataArray[0][@"subTitle"] ];
    [self.contentView addSubview:leftBtn];
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(MXScreen_Width / 2, 20, 0.5, buttonHeight - 30)];
    lineView.backgroundColor = [UIColor mx_colorWithHexString:@"dddddd"];
    [self.contentView addSubview:lineView];
    
    // 右边按钮
    MXHomeServiceBtn *rightBtn = [[MXHomeServiceBtn alloc] initWithFrame:CGRectMake(MXScreen_Width / 2, 0, MXScreen_Width / 2, buttonHeight) index:1 title:self.dataArray[1][@"title"] subTitle:self.dataArray[1][@"subTitle"]];
    [self.contentView addSubview:rightBtn];
}

- (void)initConstraint
{
    
}
@end
