//
//  MXCommunityMarketVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXCommunityMarketVC.h"
#import "MXCommunityMarketCell.h"

#import "MXCommunityMarketModel.h"

extern NSInteger const MXCommunityScrollTitleHeight;
#define MXCommunityMarketCellHeight 270
#define MXCommunityMarketSectionHeight 10

@interface MXCommunityMarketVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *modelsArray;

@end

@implementation MXCommunityMarketVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initData
{
    MXCommunityMarketModel *model1= [[MXCommunityMarketModel alloc] init];
    model1.iconName = @"icon_user1";
    model1.nickName = @"前海吴彦祖";
    model1.desString = @"本人有亮Jeep专卖，有意向请联系本人";
    model1.imageName = @"mark_cell_image1";
    
    MXCommunityMarketModel *model2= [[MXCommunityMarketModel alloc] init];
    model2.iconName = @"icon_user2";
    model2.nickName = @"尼古拉斯赵6";
    model2.desString = @"LV包包不想要了，有人想买的吗？";
    model2.imageName = @"mark_cell_image2";
    
    MXCommunityMarketModel *model3= [[MXCommunityMarketModel alloc] init];
    model3.iconName = @"icon_user3";
    model3.nickName = @"后海奔驰旗舰店";
    model3.desString = @"新车即将上市......嘻嘻嘻";
    model3.imageName = @"mark_cell_image3";

    self.modelsArray = @[model1, model2, model3];
}

- (void)initNavBar
{
    
}

- (void)initUI
{
    self.title = @"跳蚤市场";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - MX_NAV_HEIGHT - MXCommunityScrollTitleHeight) style:UITableViewStyleGrouped];
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MXCommunityMarketCell class]) bundle:nil] forCellReuseIdentifier:@"MXCommunityMarketCell"];
    [self.view addSubview:tableView];
}

- (void)initConstraint
{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 内部方法

#pragma mark - UITabelDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXCommunityMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXCommunityMarketCell"];
    cell.model = self.modelsArray[indexPath.section];
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return MXCommunityMarketSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXCommunityMarketCellHeight;
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
}
@end
