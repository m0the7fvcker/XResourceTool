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
    tableView.backgroundColor = [UIColor mx_colorWithHexString:@"F7F5F5"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noDisturbId_OneKey];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDisturbId_OneKey];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = @"一键免打扰";
        UISwitch *sw = [[UISwitch alloc] init];
        [sw addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
        [sw setOn:[MXComUserDefault getUserNoDisturbSetting] animated:NO];
        cell.accessoryView = sw;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 60)];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MXScreen_Width - 20, 60)];
    desLabel.text = @"开启后，您将不再接收到来自门禁主机给您发出的通话请求";
    desLabel.font = [UIFont systemFontOfSize:15];
    desLabel.numberOfLines = 0;
    [containerView addSubview:desLabel];
    return containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        MXNoDisturbInnerVC *innerVC = [[MXNoDisturbInnerVC alloc] init];
        [self.navigationController pushViewController:innerVC animated:YES];
    }
}

#pragma mark - 内部方法
- (void)switchDidChange:(UISwitch *)sw
{
    BOOL on = [MXComUserDefault getUserNoDisturbSetting];
    [MXComUserDefault saveUserNoDisturbSetting:![MXComUserDefault getUserNoDisturbSetting]];
}

@end
