//
//  MXScoreMallVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXScoreMallVC.h"
#import "MXScoreMallMenu.h"
#import "MXLoveHomeCell.h"// The same as MXLoveHomeCell
#import "MXScoreMallHeader.h"

#define MXScoreMallMenuHeight 200
#define MXScoreMallBottomHeight 79
#define MXScoreMallCycleHeight 230
#define MXScoreMallCellHeight 192
#define MXScoreMallSectionHeight 10

extern NSString *const LoveHomeCell;
//static NSString *const ScoreMallCell = @"ScoreMallCell";// The same as MXLoveHomeCell

@interface MXScoreMallVC ()<UITableViewDataSource, UITableViewDelegate, MXScoreMallMenuDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXScoreMallMenu *headerMenu;
/** 顶部积分菜单 */
@property (nonatomic, weak) MXScoreMallHeader *scoreHeader;
/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;
@end

@implementation MXScoreMallVC

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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScoreMallMenuHeight + MXScoreMallCycleHeight)];
        // 积分菜单
        MXScoreMallHeader *header = [[MXScoreMallHeader alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScoreMallCycleHeight)];
        self.scoreHeader = header;
        [headerView addSubview:header];
        
        // 菜单按钮
        MXScoreMallMenu *menuView = [[MXScoreMallMenu alloc] initWithFrame:CGRectMake(0, MXScoreMallCycleHeight, MXScreen_Width, MXScoreMallMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
        menuView.backgroundColor   = [UIColor whiteColor];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        
        headerView;
    });
    self.tableView = tableView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MXLoveHomeCell class]) bundle:nil]forCellReuseIdentifier:LoveHomeCell];
    [self.view addSubview:tableView];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXLoveHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:LoveHomeCell];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXScoreMallCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXScoreMallSectionHeight)];
        sectionHeader.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
        return sectionHeader;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MXScoreMallSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)MXScoreMallMenuButtonDidClick:(NSInteger)btnNumber
{
    
}

@end
