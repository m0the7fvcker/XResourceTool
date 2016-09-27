//
//  MXNoDisturbInnerVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXNoDisturbInnerVC.h"

static NSString *const noDisturbInnerId_Set = @"MX_NoDisturbInner_Set";
static NSString *const noDisturbInnerId_Shield = @"MX_NoDisturbInner_Shield";

@interface MXNoDisturbInnerVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MXNoDisturbInnerVC

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScreen_Height - MX_NAV_HEIGHT) style:UITableViewStylePlain];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 3;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noDisturbInnerId_Set];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDisturbInnerId_Set];
            cell.textLabel.text = @"一键免打扰";
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noDisturbInnerId_Shield];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDisturbInnerId_Shield];
            cell.textLabel.text = @"01区01栋01单元01";
            cell.accessoryView = [[UISwitch alloc] init];
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

@end
