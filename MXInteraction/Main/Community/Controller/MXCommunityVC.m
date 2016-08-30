//
//  MXCommunityVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXCommunityVC.h"
#import "MXCommunityCell.h"

#import "MXCommunityModel.h"

extern NSInteger const MXCommunityScrollTitleHeight;
#define MXCommunityCellHeight 180
#define MXCommunitySectionHeaderHeight 10

@interface MXCommunityVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *modelsArray;
@end

@implementation MXCommunityVC

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
    MXCommunityModel *model1 = [[MXCommunityModel alloc] init];
    model1.iconName = @"icon_user4";
    model1.nickName = @"智慧社区活动";
    model1.timeString = @"2016.8.6";
    model1.desString = @"社区商业作为商业地产的一个重要类别，虽然没有购物中心琳琅满目、富丽堂皇，但却是最贴近居民生活的，好的商业社区布局直接关系到周边居民的生活品质如何。社区商业从最开始的底商模式，到后来的商业步行街模式，再到现在邻里中心式的社区商业模式，在不断地发展过程中，有些地方也会出现两种模式并存的情况。";
    model1.imageName = @"";
    
    self.modelsArray = @[model1];
}

- (void)initNavBar
{
    
}

- (void)initUI
{
    self.title = @"社区沙龙";
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MXCommunityCell class]) bundle:nil] forCellReuseIdentifier:@"MXCommunityCell"];
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
    return self.modelsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXCommunityCell"];
    cell.model = self.modelsArray[indexPath.section];
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return MXCommunitySectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXCommunityCellHeight;
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

@end
