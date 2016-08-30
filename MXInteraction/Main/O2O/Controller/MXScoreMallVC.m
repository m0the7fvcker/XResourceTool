//
//  MXScoreMallVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXScoreMallVC.h"
#import "MXO2OCommonMenu.h"
#import "MXLoveHomeCell.h"// The same as MXLoveHomeCell
#import "MXScoreMallHeader.h"

#import "MXO2OCommonModel.h"

#define MXScoreMallMenuHeight 200
#define MXScoreMallBottomHeight 79
#define MXScoreMallCycleHeight 230
#define MXScoreMallCellHeight 192
#define MXScoreMallSectionHeight 10

extern NSString *const LoveHomeCell;
//static NSString *const ScoreMallCell = @"ScoreMallCell";// The same as MXLoveHomeCell

@interface MXScoreMallVC ()<UITableViewDataSource, UITableViewDelegate, MXO2OCommonMenuDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXO2OCommonMenu *headerMenu;
/** 顶部积分菜单 */
@property (nonatomic, weak) MXScoreMallHeader *scoreHeader;
/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;
/** 模型数组 */
@property (nonatomic, strong) NSArray *modelsArray;

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
    
    self.menuImages = @[@"icon_store_jifen_0",
                        @"icon_store_jifen_1",
                        @"icon_store_jifen_2",
                        @"icon_store_jifen_3"];
    
    MXO2OCommonModel *model1 = [[MXO2OCommonModel alloc] init];
    model1.titleName = @"产品分类";
    model1.imageName = @"bg_banner_jifen_cell_0";
    
    self.modelsArray = @[model1];
    
}

- (void)initNavBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mx_itemWithImageName:@"icon_store_jifen_share" highImageName:nil target:self action:@selector(rightShareClick)];
}

- (void)initUI
{
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - MX_NAV_HEIGHT) style:UITableViewStyleGrouped];
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
        MXO2OCommonMenu *menuView = [[MXO2OCommonMenu alloc] initWithFrame:CGRectMake(0, MXScoreMallCycleHeight, MXScreen_Width, MXScoreMallMenuHeight) withButtonTitles:self.menuTitles buttonImages:self.menuImages andRowCount:2];
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

#pragma mark - 内部方法
- (void)rightShareClick
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXLoveHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:LoveHomeCell];
    cell.model = self.modelsArray[indexPath.section];
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

- (void)MXO2OCommonMenuButtonDidClick:(NSInteger)btnNumber
{
    
}

@end
