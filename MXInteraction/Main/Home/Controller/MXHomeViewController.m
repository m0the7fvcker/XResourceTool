//
//  MXHomeViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeViewController.h"
#import "MXHomeHeaderMenu.h"
#import "MXHomeBottomBar.h"
#import "SDCycleScrollView.h"
#import "BHBPopView.h"
#import "MXHomeServiceCell.h"

#import "MXOpenRecordVC.h"
#import "MXNoDisturbVC.h"
#import "MXPersonalCenterVC.h"
#import "MXCommunityControlVC.h"
#import "MXO2OVC.h"

#define MXHomeMenuHeight 220
#define MXHomeBottomHeight 79
#define MXHomeCycleHeight 230
#define MXHomeCellHeight 192
#define MXHomeSectionHeight 15

@interface MXHomeViewController ()<UITableViewDelegate, UITableViewDataSource, MXHomeHeaderMenuDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部轮播图 */
@property (nonatomic, weak) SDCycleScrollView *cycleView;
/** 底部钥匙条 */
@property (nonatomic, weak) MXHomeBottomBar *bottomBar;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXHomeHeaderMenu *headerMenu;
/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;

@end

@implementation MXHomeViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNotification];
    [self initData];
    [self initNavBar];
    [self initUI];
    [self initConstraint];

}

- (void)addNotification
{
    // 监听cell中物业、电梯服务点击
    [MXNotificationCenterAccessor addObserver:self selector:@selector(houseSrv) name:MXNoti_Home_HouseSrv object:nil];
    [MXNotificationCenterAccessor addObserver:self selector:@selector(elevatorSrv) name:MXNoti_Home_ElevatorSrv object:nil];
}

- (void)dealloc
{
    [MXNotificationCenterAccessor removeObserver:self];
}

#pragma mark - 初始化方法
- (void)initData
{
    self.menuTitles = @[@"可视对讲",
                       @"开门记录",
                       @"授权管理",
                       @"免打扰",
                       @"社区互帮",
                       @"O2O商城",
                       @"智享体验",
                       @"分享开门"];
    
    self.menuImages = @[@"home_icon_0",
                        @"home_icon_1",
                        @"home_icon_2",
                        @"home_icon_3",
                        @"home_icon_4",
                        @"home_icon_5",
                        @"home_icon_6",
                        @"home_icon_7"];
}

- (void)initNavBar
{
    self.title = @"01区01栋01单元0201";
    self.view.backgroundColor = [UIColor clearColor];
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem mx_itemWithImageName:@"home_icon_user" highImageName:nil target:self action:@selector(personalCenterClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mx_itemWithImageName:@"home_icon_no_news" highImageName:nil target:self action:@selector(messageClick)];
}

- (void)initUI
{
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - MXHomeBottomHeight) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.backgroundColor= [UIColor mx_colorWithHexString:@"ececec"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeMenuHeight + MXHomeCycleHeight)];
        
        UIImage *image1 = [UIImage imageNamed:@"banner1.png"];
        UIImage *image2 = [UIImage imageNamed:@"banner2.png"];
        UIImage *image3 = [UIImage imageNamed:@"banner3.png"];
        NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:image1, image2, image3, nil];
        
        // 顶部轮播图
        SDCycleScrollView *cycleView         = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeCycleHeight) imageNamesGroup:imageArray];
        cycleView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        cycleView.autoScrollTimeInterval     = 3.0f;
        cycleView.pageControlStyle           = SDCycleScrollViewPageContolStyleClassic;
        cycleView.delegate                   = self;
        cycleView.pageControlAliment         = SDCycleScrollViewPageContolAlimentRight;
        cycleView.titleLabelHeight           = 23.0f;
        cycleView.titleLabelBackgroundColor  = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
        [headerView addSubview:cycleView];
        
        // 菜单按钮
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, MXHomeCycleHeight, MXScreen_Width, MXHomeMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
        menuView.backgroundColor   = [UIColor whiteColor];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        
        headerView;
    });
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    // 创建底部钥匙条，UI背景图左右宽度不一致，WTF，所以杀鸡取卵，x设置为-1
    MXWeakSelf;
    MXHomeBottomBar *bottomBar = [[MXHomeBottomBar alloc] initWithFrame:CGRectMake(- 1, MXScreen_Height - MX_NAV_HEIGHT - MXHomeBottomHeight, MXScreen_Width + 2, MXHomeBottomHeight) andClickBlock:^{
        [weakSelf bottomBarKeyClick];
    }];
    NSLog(@"%lf",bottomBar.width);
    self.bottomBar = bottomBar;
    [self.view addSubview:bottomBar];
    


}

- (void)initConstraint
{
    
}

#pragma mark - 内部方法
- (void)personalCenterClick
{
    MXPersonalCenterVC *personCenterVC = [[MXPersonalCenterVC alloc] init];
    [self.navigationController pushViewController:personCenterVC animated:YES];
}

- (void)messageClick
{
    
}

- (void)houseSrv
{
    NSLog(@"物业服务");
}

- (void)elevatorSrv
{
    NSLog(@"电梯服务");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXHomeServiceCell *cell = [[MXHomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MXHomeCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeSectionHeight)];
        sectionHeader.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
        return sectionHeader;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MXHomeSectionHeight;
}

#pragma mark - MXHomeHeaderMenuDelegate
- (void)MXHomeHeaderMenuButtonDidClick:(NSInteger)btnNumber
{
    switch (btnNumber) {
            // 可视对讲
        case 0:
        {
            
        }
            break;
            // 开门记录
        case 1:
        {
            MXOpenRecordVC *recordVC = [[MXOpenRecordVC alloc] init];
            [self.navigationController pushViewController:recordVC animated:YES];
        }
            break;
            // 授权管理
        case 2:
        {
            
        }
            break;
            // 免打扰
        case 3:
        {
            MXNoDisturbVC *noDisturbVC = [[MXNoDisturbVC alloc] init];
            [self.navigationController pushViewController:noDisturbVC animated:YES];
        }
            break;
            // 社区互帮
        case 4:
        {
            MXCommunityControlVC *communityControlVC = [[MXCommunityControlVC alloc] init];
            [self.navigationController pushViewController:communityControlVC animated:YES];
        }
            break;
            // o2o商城
        case 5:
        {
            MXO2OVC *o2oVC = [[MXO2OVC alloc] init];
            [self.navigationController pushViewController:o2oVC animated:YES];
        }
            break;
            // 智享体验
        case 6:
        {
            
        }
            break;
            // 分享开门
        case 7:
        {
            
        }
            break;
        default:
            break;
    }

}

#pragma mark - SDCycleScrollViewDelegate代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"点击了%ld个按钮",index);
}

#pragma mark - 底部钥匙按钮点击
- (void)bottomBarKeyClick
{
    //添加popview
    [BHBPopView showToView:MXApplicationAccessor.keyWindow
                 andImages:@[@"images.bundle/tabbar_compose_idea",
                             @"images.bundle/tabbar_compose_photo",
                             @"images.bundle/tabbar_compose_camera",
                             @"images.bundle/tabbar_compose_lbs",
                             @"images.bundle/tabbar_compose_review",
                             @"images.bundle/tabbar_compose_more"]
                 andTitles:@[@"Text",
                             @"Albums",
                             @"Camera",
                             @"Check in",
                             @"Review",
                             @"More"]
            andSelectBlock:^(BHBItem *item) {
                
            }
     ];


}

@end
