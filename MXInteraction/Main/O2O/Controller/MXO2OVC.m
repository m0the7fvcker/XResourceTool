//
//  MXO2OVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXO2OVC.h"
#import "MXO2OCell.h"

#import "MXO2OModel.h"

#import "MXLoveHomeVC.h"
#import "MXScoreMallVC.h"
#import "MXSelllerAreaVC.h"

#define MXO2OCellHeight 250
#define MXO2OSectionHeaderHeight 10

@interface MXO2OVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *> *dataArray;
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
    self.dataArray = @[@{@"icon" : @"icon_personal_bar0",
                         @"title" : @"爱家e站",
                         @"image" : @"banner1.png"},
                       @{@"icon" : @"icon_personal_bar0",
                         @"title" : @"积分商城",
                         @"image" : @"banner1.png"},
                       @{@"icon" : @"icon_personal_bar0",
                         @"title" : @"商家商圈",
                         @"image" : @"banner1.png"}];
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
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXO2OCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXO2OCell"];
    cell.leftIcon.image = self.dataArray[indexPath.section][@"icon"];
    cell.nameLabel.text = self.dataArray[indexPath.section][@"title"];
    cell.centerImage.image = self.dataArray[indexPath.section][@"image"];
    
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
