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
#import "MXLoveHomeCell.h"

#define MXLoveHomeMenuHeight 220
#define MXLoveHomeBottomHeight 79
#define MXLoveHomeCycleHeight 230
#define MXLoveHomeCellHeight 192
#define MXLoveHomeSectionHeight 10

NSString *const LoveHomeCell = @"LoveHomeCell";

@interface MXLoveHomeVC ()<UITableViewDataSource, UITableViewDelegate, MXHomeHeaderMenuDelegate, SDCycleScrollViewDelegate>

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

@implementation MXLoveHomeVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initNavBar];
    [self initUI];
}

#pragma mark- 初始化方法
- (void)initData
{
    self.menuTitles = @[@"日化用品",
                        @"柴米油盐",
                        @"零食小铺",
                        @"瓜果生疏",
                        @"日用百货",
                        @"爱家医疗",
                        @"只能硬件",
                        @"全部分类"];
    
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
    self.title = @"爱家e站";
    
    UIBarButtonItem *rightBarButton = [UIBarButtonItem mx_itemWithImageName:@"home_icon_no_news" highImageName:@"home_icon_news" target:self action:@selector(messageClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXLoveHomeMenuHeight + MXLoveHomeCycleHeight)];
        
        UIImage *image1 = [UIImage imageNamed:@"banner1.png"];
        UIImage *image2 = [UIImage imageNamed:@"banner2.png"];
        UIImage *image3 = [UIImage imageNamed:@"banner3.png"];
        NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:image1, image2, image3, nil];
        
        // 顶部轮播图
        SDCycleScrollView *cycleView         = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MXScreen_Width, MXLoveHomeCycleHeight) imageNamesGroup:imageArray];
        cycleView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        cycleView.autoScrollTimeInterval     = 3.0f;
        cycleView.pageControlStyle           = SDCycleScrollViewPageContolStyleClassic;
        cycleView.delegate                   = self;
        cycleView.pageControlAliment         = SDCycleScrollViewPageContolAlimentRight;
        cycleView.titleLabelHeight           = 23.0f;
        cycleView.titleLabelBackgroundColor  = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
        [headerView addSubview:cycleView];
        
        // 菜单按钮
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, MXLoveHomeCycleHeight, MXScreen_Width, MXLoveHomeMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
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

#pragma mark - 内部方法
- (void)messageClick
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
    return MXLoveHomeCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXLoveHomeSectionHeight)];
        sectionHeader.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
        return sectionHeader;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MXLoveHomeSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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

#pragma mark - SDCycleScrollViewDelegate代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"点击了%ld个按钮",index);
}
@end
