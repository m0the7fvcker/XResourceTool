//
//  MXNoDisturbVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXNoDisturbVC.h"
#import "MXNoDisturbInnerVC.h"

static NSString *const noDisturbId_OneKey = @"MX_NoDisturb_OnkeKey";
static NSString *const noDisturbId_Location = @"MX_NoDisturb_Location";

@interface MXNoDisturbVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISwitch *oneKeySw;

@end

@implementation MXNoDisturbVC

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
    UISwitch *oneKeySw = [[UISwitch alloc] init];
    oneKeySw.on = NO;
    [oneKeySw addTarget:self action:@selector(oneKeySwitchChange:) forControlEvents:UIControlEventValueChanged];
    self.oneKeySw = oneKeySw;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScreen_Height - MX_NAV_HEIGHT) style:UITableViewStyleGrouped];
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

#pragma mark - 内部方法
- (void)oneKeySwitchChange:(UISwitch *)onekeySw
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noDisturbId_OneKey];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDisturbId_OneKey];
            cell.textLabel.text = @"一键免打扰";
            cell.accessoryView = [[UISwitch alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noDisturbId_Location];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDisturbId_Location];
            cell.textLabel.text = @"01区01栋01单元01";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
    }
   
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        MXNoDisturbInnerVC *innerVC = [[MXNoDisturbInnerVC alloc] init];
        [self.navigationController pushViewController:innerVC animated:YES];
    }
}
@end
