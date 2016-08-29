//
//  MXSelllerAreaVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXSelllerAreaVC.h"
#import "MXScoreMallMenu.h"

#define MXSelllerAreaMenuHeight 200
#define MXSelllerAreaBottomHeight 79
#define MXSelllerAreaCycleHeight 230
#define MXSelllerAreaCellHeight 192
#define MXSelllerAreaSectionHeight 10

@interface MXSelllerAreaVC ()<UITableViewDataSource, UITableViewDelegate, MXScoreMallMenuDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXScoreMallMenu *headerMenu;
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
    self.menuTitles = @[@"新品推荐",
                        @"积分兑换服务",
                        @"积分抽奖",
                        @"积分当钱花"
                        ];
    
    self.menuImages = @[@"home_icon_0",
                        @"home_icon_1",
                        @"home_icon_2",
                        @"home_icon_3"];
}

- (void)initNavBar
{
    
}

- (void)initUI
{
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height) style:UITableViewStyleGrouped];
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
        imageView.image = [UIImage imageNamed:@"banner1.png"];
        [headerView addSubview:imageView];
        
        // 菜单按钮
        MXScoreMallMenu *menuView = [[MXScoreMallMenu alloc] initWithFrame:CGRectMake(0, MXSelllerAreaCycleHeight, MXScreen_Width, MXSelllerAreaMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
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

- (void)MXScoreMallMenuButtonDidClick:(NSInteger)btnNumber
{
    
}
@end
