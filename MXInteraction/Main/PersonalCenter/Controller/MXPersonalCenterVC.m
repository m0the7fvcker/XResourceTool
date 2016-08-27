//
//  MXPersonalCenterVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/24.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXPersonalCenterVC.h"
#import "MXPersonalHeaderView.h"
#import "MXPersonalHeaderBar.h"

#define MXPersonalHeaderHeight 240
#define MXPersonalHeaderTopHeight 180
#define MXPersonalHeaderBarHeight 60
#define MXPersonalSectionHeaderHeight 10
#define MXPersonalCellHeight 50

static NSString *const MXPersonalCell = @"MXPersonalCell";

@interface MXPersonalCenterVC()<UITableViewDataSource, UITableViewDelegate, MXPersonalHeaderBarDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 底部钥匙条 */
@property (nonatomic, weak) MXPersonalHeaderView *headerView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXPersonalHeaderBar *headerBar;
/** 第一组数据 */
@property (nonatomic, strong) NSArray <NSDictionary *> *firstSection;
/** 第二组数据 */
@property (nonatomic, strong) NSArray <NSDictionary *> *secondSection;

@end

@implementation MXPersonalCenterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self initConstraint];
}

- (void)initData
{
    self.firstSection = @[@{@"title" : @"我的资产",
                            @"imageName" : @"icon_personal_section1_0"},
                          @{@"title" : @"我的订单",
                            @"imageName" : @"icon_personal_section1_1"},
                          @{@"title" : @"配送管理",
                            @"imageName" : @"icon_personal_section1_2"},
                          @{@"title" : @"我的收藏",
                            @"imageName" : @"icon_personal_section1_3"},
                          @{@"title" : @"购物车",
                            @"imageName" : @"icon_personal_section1_4"}
                         ];
    
    self.secondSection = @[@{@"title" : @"意见反馈",
                             @"imageName" : @"icon_personal_section2_0"},
                           @{@"title" : @"清空缓存",
                             @"imageName" : @"icon_personal_section2_1"},
                           @{@"title" : @"设置",
                             @"imageName" : @"icon_personal_section2_2"}
                          ];
}

- (void)initUI
{
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
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXPersonalHeaderHeight)];
        
        // 顶部视图
        MXPersonalHeaderView *headerView = [[MXPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXPersonalHeaderTopHeight)];
        headerView.backgroundColor = [UIColor mx_colorWithHexString:@"12ade7"];
        self.headerView = headerView;
        [tableHeaderView addSubview:headerView];
        
        // 顶部菜单条
        MXPersonalHeaderBar *headerBar = [[MXPersonalHeaderBar alloc] initWithFrame:CGRectMake(0, MXPersonalHeaderTopHeight, MXScreen_Width, MXPersonalHeaderBarHeight)];
        headerBar.delegate = self;
        headerBar.backgroundColor = [UIColor whiteColor];
        self.headerBar = headerBar;
        [tableHeaderView addSubview:headerBar];
        tableHeaderView;
    });
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)initConstraint
{
    
}

#pragma mark - 内部方法


#pragma mark - UITabelDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSection.count;
    }else {
        return self.secondSection.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MXPersonalCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:self.firstSection[indexPath.row][@"imageName"]];
        cell.textLabel.text = self.firstSection[indexPath.row][@"title"];
    }else {
        cell.imageView.image = [UIImage imageNamed:self.secondSection[indexPath.row][@"imageName"]];
        cell.textLabel.text = self.secondSection[indexPath.row][@"title"];
    }
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MXPersonalSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXPersonalCellHeight;
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

#pragma mark - MXPersonalHeaderBarDelegate
- (void)MXPersonalHeaderBarButtonDidClick:(NSInteger)btnNumber
{
    switch (btnNumber) {
        case 0:
            NSLog(@"余额");
            break;
        case 1:
            NSLog(@"积分");
            break;
        case 2:
            NSLog(@"金豆");
            break;
        case 3:
            NSLog(@"消息");
            break;
        default:
            break;
    }
}

@end
