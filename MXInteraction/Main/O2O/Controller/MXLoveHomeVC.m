//
//  MXLoveHomeVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLoveHomeVC.h"
#import "MXHomeHeaderMenu.h"
#import "MXHomeBottomBar.h"
#import "SDCycleScrollView.h"
#import "BHBPopView.h"
#import "MXHomeServiceCell.h"

#define MXHomeMenuHeight 220
#define MXHomeBottomHeight 79
#define MXHomeCycleHeight 230
#define MXHomeCellHeight 192
#define MXHomeSectionHeight 15

@interface MXLoveHomeVC ()<UITableViewDataSource, UITableViewDelegate, MXHomeHeaderMenuDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部轮播图 */
@property (nonatomic, weak) SDCycleScrollView *cycleView;
/** 底部钥匙条 */
@property (nonatomic, weak) MXHomeBottomBar *bottomBar;
/** 顶部按钮菜单 */
@property (nonatomic, weak) MXHomeHeaderMenu *headerMenu;

@end

@implementation MXLoveHomeVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self initUI];
}

#pragma mark- 初始化方法
- (void)initNavBar
{
    
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
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, MXHomeCycleHeight, MXScreen_Width, MXHomeMenuHeight)];
        menuView.backgroundColor   = [UIColor whiteColor];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        
        headerView;
    });
    self.tableView = tableView;
    [self.view addSubview:tableView];

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
            // 日化用品
        case 0:
        {
            
        }
            break;
            // 柴米油盐
        case 1:
        {

        }
            break;
            // 零食小铺
        case 2:
        {
            
        }
            break;
            // 瓜果生蔬
        case 3:
        {

        }
            break;
            // 日用百货
        case 4:
        {
   
        }
            break;
            // 爱家医疗
        case 5:
        {
 
        }
            break;
            // 智能硬件
        case 6:
        {
            
        }
            break;
            // 全部分类
        case 7:
        {
            
        }
            break;
        default:
            break;
    }
    
}

- (void)bottomBarKeyClick
{
    
}

#pragma mark - SDCycleScrollViewDelegate代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"点击了%ld个按钮",index);
}
@end
