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

#define MXPersonalHeaderHeight 250
#define MXPersonalHeaderTopHeight 200
#define MXPersonalHeaderBarHeight 50

@interface MXPersonalCenterVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 底部钥匙条 */
@property (nonatomic, weak) MXPersonalHeaderView *headerView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXPersonalHeaderBar *headerBar;

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
    
}

- (void)initUI
{
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScreen_Height) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.backgroundColor= [UIColor mx_colorWithHexString:@"ececec"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXPersonalHeaderHeight)];
        
        // 顶部视图
        MXPersonalHeaderView *headerView = [[MXPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXPersonalHeaderTopHeight)];
        headerView.backgroundColor = [UIColor mx_randomColor];
        self.headerView = headerView;
        [tableHeaderView addSubview:headerView];
        
        // 顶部菜单条
        MXPersonalHeaderBar *headerBar = [[MXPersonalHeaderBar alloc] initWithFrame:CGRectMake(0, MXPersonalHeaderTopHeight, MXScreen_Width, MXPersonalHeaderBarHeight)];
        headerBar.backgroundColor = [UIColor mx_randomColor];
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

#pragma mark - UITabelDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - UITableDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
