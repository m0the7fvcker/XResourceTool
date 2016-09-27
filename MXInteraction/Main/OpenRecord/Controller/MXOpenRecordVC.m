//
//  MXOpenRecordVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordVC.h"

#import "MXOpenRecordSectionHeader.h"
#import "MXOpenRecordCell.h"

static NSString *const openRecordCell = @"OpenRecordCell";
static NSString *const openRecordSectionHeader = @"OpenRecordSectionHeader";

@interface MXOpenRecordVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MXOpenRecordVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource   = self;
    tableView.delegate     = self;
    self.tableView         = tableView;
    [self.view addSubview:tableView];
}

- (void)initNavBar
{
    
}

- (void)initConstraint
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXOpenRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"openRecordCell"];
    if (!cell) {
        cell = [[MXOpenRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"openRecordCell"];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MXOpenRecordSectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openRecordSectionHeader"];
    if (!headerView) {
        headerView = [[MXOpenRecordSectionHeader alloc] initWithReuseIdentifier:@"openRecordSectionHeader"];
    }
    headerView.title = @"周一";
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

@end
