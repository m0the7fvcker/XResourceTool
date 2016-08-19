//
//  MXOpenRecordVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordVC.h"

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
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"我是cell";
    
    return cell;
}
#pragma mark - UITableViewDelegate


@end
