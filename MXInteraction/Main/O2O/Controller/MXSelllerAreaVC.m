//
//  MXSelllerAreaVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXSelllerAreaVC.h"
#import "MXO2OCommonMenu.h"

#define MXSelllerAreaMenuHeight 200
#define MXSelllerAreaBottomHeight 79
#define MXSelllerAreaCycleHeight 230
#define MXSelllerAreaCellHeight 192
#define MXSelllerAreaSectionHeight 10

@interface MXSelllerAreaVC ()<UITableViewDataSource, UITableViewDelegate, MXO2OCommonMenuDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXO2OCommonMenu *headerMenu;
/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;

@end

@implementation MXSelllerAreaVC
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
    self.menuTitles = @[@"快递收发",
                        @"家政洗衣",
                        @"家电维修",
                        @"订餐服务",
                        @"手机宽带缴费",
                        @"更多"
                        ];
    
    self.menuImages = @[@"icon_store_area_0",
                        @"icon_store_area_1",
                        @"icon_store_area_2",
                        @"icon_store_area_3",
                        @"icon_store_area_4",
                        @"icon_store_area_5"];
}

- (void)initNavBar
{
    
}

- (void)initUI
{
    self.title = @"商家商圈";
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - MX_NAV_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.backgroundColor= [UIColor mx_colorWithHexString:@"ececec"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXSelllerAreaMenuHeight + MXSelllerAreaCycleHeight)];
        // 顶部图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXSelllerAreaCycleHeight)];
        imageView.image = [UIImage imageNamed:@"icon_store_area_banner"];
        [headerView addSubview:imageView];
        
        // 菜单按钮
        MXO2OCommonMenu *menuView = [[MXO2OCommonMenu alloc] initWithFrame:CGRectMake(0, MXSelllerAreaCycleHeight, MXScreen_Width, self.view.height - MXSelllerAreaCycleHeight - MX_NAV_HEIGHT) withButtonTitles:self.menuTitles buttonImages:self.menuImages andRowCount:3];
        menuView.backgroundColor   = [UIColor whiteColor];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        
        headerView;
    });
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
}

- (void)initConstraint
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXSelllerAreaCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXSelllerAreaSectionHeight)];
        sectionHeader.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
        return sectionHeader;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MXSelllerAreaSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)MXO2OCommonMenuButtonDidClick:(NSInteger)btnNumber
{
    
}
@end
