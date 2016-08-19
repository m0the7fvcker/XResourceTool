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

#import "MXOpenRecordVC.h"
#import "MXNoDisturbVC.h"

#define MXHomeHeaderHeight 400
#define MXHomeBottomHeight 54

@interface MXHomeViewController ()<UITableViewDelegate, UITableViewDataSource, MXHomeHeaderMenuDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部轮播图 */
@property (nonatomic, weak) SDCycleScrollView *cycleView;
/** 底部钥匙条 */
@property (nonatomic, weak) MXHomeBottomBar *bottomBar;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXHomeHeaderMenu *headerMenu;

@end

@implementation MXHomeViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initNavBar
{
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"个人中心" style:UIBarButtonItemStyleDone target:self action:@selector(personalCenterClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(messageClick)];
    
}

- (void)initUI
{
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, MX_NAV_HEIGHT, MXScreen_Width, self.view.height - MXHomeBottomHeight) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeHeaderHeight)];
        
        UIImage *image1 = [UIImage imageNamed:@"1.png"];
        UIImage *image2 = [UIImage imageNamed:@"2.png"];
        UIImage *image3 = [UIImage imageNamed:@"3.png"];
        NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:image1, image2, image3, nil];
        
        // 顶部轮播图
        SDCycleScrollView *cycleView         = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MXScreen_Width, 200) imageNamesGroup:imageArray];
        cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        cycleView.autoScrollTimeInterval     = 3.0f;
        cycleView.pageControlStyle           = SDCycleScrollViewPageContolStyleClassic;
        cycleView.delegate                   = self;
        cycleView.pageControlAliment         = SDCycleScrollViewPageContolAlimentRight;
        cycleView.titleLabelHeight           = 23.0f;
        cycleView.titleLabelBackgroundColor  = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
        [headerView addSubview:cycleView];
        
        // 菜单按钮
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, 200, MXScreen_Width, 200)];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        
        headerView;
    });
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    // 创建底部钥匙条
    MXWeakSelf;
    MXHomeBottomBar *bottomBar = [[MXHomeBottomBar alloc] initWithFrame:CGRectMake(0, MXScreen_Height - MXHomeBottomHeight, MXScreen_Width, MXHomeBottomHeight) andClickBlock:^{
        [weakSelf bottomBarKeyClick];
    }];
    self.bottomBar = bottomBar;
    [self.view addSubview:bottomBar];
    
}

- (void)initConstraint
{
    
}

#pragma mark - 内部方法
- (void)personalCenterClick
{
    
}

- (void)messageClick
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor mx_randomColor];
    cell.textLabel.text = @"我是cell";
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
            
        }
            break;
            // o2o商城
        case 5:
        {
            
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
