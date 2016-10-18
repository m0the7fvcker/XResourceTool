//
//  MXO2OVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXO2OVC.h"
#import "MXO2OCell.h"

#import "MXO2OCommonModel.h"

#import "MXLoveHomeVC.h"
#import "MXScoreMallVC.h"
#import "MXSelllerAreaVC.h"

#define MXO2OCellHeight 250
#define MXO2OSectionHeaderHeight 10

@interface MXO2OVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray <MXO2OCommonModel *> *modelArray;
@end

@implementation MXO2OVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initData
{
    MXO2OCommonModel *model1 = [[MXO2OCommonModel alloc] init];
    model1.iconName = @"icon_store_aijia";
    model1.titleName = @"爱家e站";
    model1.imageName = @"bg_banner_O2O_0";
    
    MXO2OCommonModel *model2 = [[MXO2OCommonModel alloc] init];
    model2.iconName = @"icon_store_jifen";
    model2.titleName = @"积分商城";
    model2.imageName = @"bg_banner_O2O_1";
    
    MXO2OCommonModel *model3 = [[MXO2OCommonModel alloc] init];
    model3.iconName = @"icon_store_area";
    model3.titleName = @"商家商圈";
    model3.imageName = @"bg_banner_O2O_2";
    
    self.modelArray = @[model1, model2 ,model3];
}

- (void)initUI
{
    self.title = @"O2O商城";
    
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScreen_Height - MX_NAV_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.backgroundColor= [UIColor mx_colorWithHexString:@"ececec"];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    
    // 消除分割线左边间隔
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    self.tableView = tableView;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MXO2OCell class]) bundle:nil]forCellReuseIdentifier:@"MXO2OCell"];
    [self.view addSubview:tableView];
}

- (void)initConstraint
{
    
}

#pragma mark - 内部方法


#pragma mark - UITabelDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXO2OCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXO2OCell"];
    cell.model = self.modelArray[indexPath.section];
    
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return MXO2OSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXO2OCellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 爱家e站
    if (indexPath.section == 0) {
        MXLoveHomeVC *loveHomeVC = [[MXLoveHomeVC alloc] init];
        [self.navigationController pushViewController:loveHomeVC animated:YES];
    // 积分商城
    } else if (indexPath.section == 1) {
        MXScoreMallVC *scoreMallVC = [[MXScoreMallVC alloc] init];
        [self.navigationController pushViewController:scoreMallVC animated:YES];
    // 商家商圈
    } else {
        MXSelllerAreaVC *selllerAreaVC = [[MXSelllerAreaVC alloc] init];
        [self.navigationController pushViewController:selllerAreaVC animated:YES];
    }
}

@end
