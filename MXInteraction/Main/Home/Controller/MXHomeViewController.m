//
//  MXHomeViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeViewController.h"
#import "MXHomeHeaderMenu.h"
#import "SDCycleScrollView.h"

#define MXHomeHeaderHeight 400

@interface MXHomeViewController ()<UITableViewDelegate, UITableViewDataSource, MXHomeHeaderMenuDelegate ,SDCycleScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) SDCycleScrollView *cycleView;

@end

@implementation MXHomeViewController

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
    // 设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage =  [UIImage new];
    
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"个人中心" style:UIBarButtonItemStyleDone target:self action:@selector(personalCenterClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(messageClick)];
    
}

- (void)initUI
{
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, MX_NAV_HEIGHT, MXScreen_Width, self.view.height) style:UITableViewStyleGrouped];
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
        menuView.delegate = self;
        
        [headerView addSubview:menuView];
        
        headerView;
    });
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}

- (void)initConstraint
{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    NSLog(@"点击了%ld个按钮",(long)btnNumber);
}

#pragma mark - SDCycleScrollViewDelegate代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"点击了%ld个按钮",index);
}
@end
