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
#import "MXHomeLeftMenu.h"

#import "MXSeeTalkingVC.h"
#import "MXOpenRecordVC.h"
#import "MXNoDisturbVC.h"
#import "MXPersonalCenterVC.h"
#import "MXCommunityControlVC.h"
#import "MXO2OVC.h"
#import "MXShareOpenVC.h"
#import "MXHomeKeyBagVC.h"

#import "MXHomeElevatorVC.h"
#import "MXHomeServiceVC.h"

#import "MXHttpRequest+LoginAndRegister.h"
#import "MXComUserDefault.h"
#import "MXUserInfoModel.h"
#import "MXHomeBannerModel.h"

#define MXHomeMenuHeight MXScreen_Width/2
#define MXHomeBottomHeight_Later6 79
#define MXHomeBottomHeight_Before 59
#define MXHomeCycleHeight_Later6 230
#define MXHomeCycleHeight_Before6 190
#define MXHomeCellHeight_Later6 192
#define MXHomeCellHeight_Before6 150
#define MXHomeSectionHeight 15

@interface MXHomeViewController ()<UITableViewDelegate, UITableViewDataSource, MXHomeHeaderMenuDelegate,SDCycleScrollViewDelegate, MXHomeLeftMenuDelegate>

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
/** 用户信息模型 */
@property (nonatomic, strong) MXUserInfoModel *userInfoModel;
/** 轮播图图片数组 */
@property (nonatomic, strong) NSMutableArray *bannersArray;
/** 顶部header */
@property (nonatomic, strong) UIView *headerView;
/** 钥匙包 */
@property (nonatomic, strong) NSArray *keyBagArray;
/** 变形后的蒙版 */
@property (nonatomic, weak) UIButton *cover;

@end

@implementation MXHomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)bannersArray
{
    if (!_bannersArray) {
        _bannersArray = [NSMutableArray array];
    }
    return _bannersArray;
}

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNotification];
    [self initNavBar];
    [self initData];
    [self initUI];
    [self initConstraint];
    [self initEMClientTool];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loginIM];
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
                       @"分享开门"
                        ];
    
    self.menuImages = @[@"home_icon_0",
                        @"home_icon_1",
                        @"home_icon_2",
                        @"home_icon_3",
                        @"home_icon_4",
                        @"home_icon_5",
                        @"home_icon_6",
                        @"home_icon_7"
                        ];
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
    CGFloat bottomBarHeight = 0;
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        bottomBarHeight = MXHomeBottomHeight_Before;
    }else {
        bottomBarHeight = MXHomeBottomHeight_Later6;
    }
    // 创建tableView
    UITableView *tableView   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - bottomBarHeight) style:UITableViewStyleGrouped];
    tableView.dataSource     = self;
    tableView.delegate       = self;
    tableView.backgroundColor= [UIColor mx_colorWithHexString:@"ececec"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat bannerHeight = 0;
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        bannerHeight = MXHomeCycleHeight_Before6;
    }else {
        bannerHeight = MXHomeCycleHeight_Later6;
    }
    // 创建tableHeaderView
    tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeMenuHeight + bannerHeight)];
        
        // 菜单按钮
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, bannerHeight, MXScreen_Width, MXHomeMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
        menuView.backgroundColor   = [UIColor whiteColor];
        menuView.delegate          = self;
        self.headerMenu            = menuView;
        [headerView addSubview:menuView];
        self.headerView = headerView;
        headerView;
    });
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    // 创建底部钥匙条，UI背景图左右宽度不一致，WTF，所以杀鸡取卵，x设置为-1
    MXWeakSelf;
    MXHomeBottomBar *bottomBar = [[MXHomeBottomBar alloc] initWithFrame:CGRectMake(- 1, MXScreen_Height - MX_NAV_HEIGHT - bottomBarHeight, MXScreen_Width + 2, bottomBarHeight) andClickBlock:^{
        [weakSelf bottomBarKeyClick];
    }];
    NSLog(@"%lf",bottomBar.width);
    self.bottomBar = bottomBar;
    [self.view addSubview:bottomBar];
    
    // 添加侧滑菜单
    MXHomeLeftMenu *leftMenuView = [[MXHomeLeftMenu alloc] initWithFrame:self.view.bounds];
    leftMenuView.delegate = self;
    leftMenuView.backgroundColor = [UIColor mx_colorWithHexString:@"39495C"];
    [MXApplicationAccessor.keyWindow insertSubview:leftMenuView atIndex:0];
    
    // 添加下拉刷新
    [MXRefresh addHeaderRefresh:self.tableView refreshingBlock:^{
        [weakSelf makeRequest];
    }];
    
    [MXRefresh beginHeaderRefresh:self.tableView];
}

- (void)initConstraint
{
    
}

- (void)initEMClientTool
{
    [MXEMClientTool shareTool];
}
#pragma mark - 内部方法

/**
 个人中心
 */
- (void)personalCenterClick
{
    [UIView animateWithDuration:0.25 animations:^{
        // 缩放为0.8倍
        CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        CGFloat leftRightMargin = MXScreen_Width * (1 - 0.8) * 0.5;
//        CGFloat topBottomMargin = MXScreen_Height * (1 - 0.8) * 0.5;
        
        CGFloat translateX = MXScreen_Width * 0.8 - leftRightMargin;
//        CGFloat translateY = 0;
        
        self.navigationController.view.transform = CGAffineTransformTranslate(transform, translateX / 0.8, 0);
        
        UIButton *cover = [[UIButton alloc] init];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = self.navigationController.view.bounds;
        self.cover = cover;
        [self.navigationController.view addSubview:cover];
        
    } completion:nil];
}

/**
 点击遮盖还原控制器
 */
- (void)coverClick:(UIButton *)cover
{
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

/**
 消息
 */
- (void)messageClick
{
    self.navigationController.view.transform = CGAffineTransformIdentity;
}

/**
 物业服务
 */
- (void)houseSrv
{
    MXHomeServiceVC *serviceVC = [[MXHomeServiceVC alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

/**
 呼叫电梯
 */
- (void)elevatorSrv
{
    MXHomeElevatorVC *elevatorVC = [[MXHomeElevatorVC alloc] init];
    elevatorVC.view.frame = CGRectMake(0, 0, MXScreen_Width, MXScreen_Height);
    [MXApplicationAccessor.keyWindow addSubview:elevatorVC.view];
    [self addChildViewController:elevatorVC];
}

/**
 请求获得用户信息
 */
- (void)makeRequest
{
    NSString *account = [MXComUserDefault getUserAccount];
    NSString *password = [MXComUserDefault getUserPasswordWithAccount:account];
    
    MXWeakSelf;
    [MXHttpRequest LoginWithPhoneNumber:account password:@"111111" appVersion:@"1-1" success:^(MXBaseDataModel * _Nonnull responseModel) {
        if (responseModel.status == MXRequestCode_Success) {
            NSLog(@"请求成功");
            weakSelf.userInfoModel = [MXUserInfoModel mx_objectWithKeyValues:responseModel.data];
            // 保存secretKey到本地，部分请求续将参数添加到请求头
            if (weakSelf.userInfoModel.secretKey) [MXComUserDefault saveUserSecretKey:weakSelf.userInfoModel.secretKey];
            // 保存imKey
            if (weakSelf.userInfoModel.imKey) [MXComUserDefault saveUserIMKey:weakSelf.userInfoModel.imKey];
            // 保存imPassword
            if (weakSelf.userInfoModel.imPassword) [MXComUserDefault saveUserIMPassword:weakSelf.userInfoModel.imPassword];
            // 保存localDeviceSerial，要添加00
            if (weakSelf.userInfoModel.roomName) [MXComUserDefault saveUserLocalDeviceSerial:[NSString stringWithFormat:@"00%@",weakSelf.userInfoModel.roomName]];
            // 获取轮播图
            [weakSelf getBannersAndRefreshWithUserInfo:weakSelf.userInfoModel];
            // 更新头部
            [weakSelf updateTableViewHeader];
            // 更新title
            [weakSelf updateTitle:weakSelf.userInfoModel.roomName];
            // 获取钥匙包
            weakSelf.keyBagArray = weakSelf.userInfoModel.myKeyBag;
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    [MXRefresh endHeaderRefresh:self.tableView];
}

/**
 请求道轮播图数据后再添加图片
 */
- (void)updateTableViewHeader
{
    MXWeakSelf;
        CGFloat bannerHeight = 0;
        if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
            bannerHeight = MXHomeCycleHeight_Before6;
        }else {
            bannerHeight = MXHomeCycleHeight_Later6;
        }
        // 顶部轮播图
        SDCycleScrollView *cycleView         = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MXScreen_Width, bannerHeight) imageURLStringsGroup:weakSelf.bannersArray];
        cycleView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        cycleView.autoScrollTimeInterval     = 3.0f;
        cycleView.pageControlStyle           = SDCycleScrollViewPageContolStyleClassic;
        cycleView.delegate                   = weakSelf;
        cycleView.pageControlAliment         = SDCycleScrollViewPageContolAlimentRight;
        cycleView.titleLabelHeight           = 23.0f;
        cycleView.titleLabelBackgroundColor  = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
        [weakSelf.headerView addSubview:cycleView];
}


/**
 修改title为房号

 @param title 房号名称
 */
- (void)updateTitle:(NSString *)title
{
    MXWeakSelf;
    
    NSRange districtNo = NSMakeRange(0, 2);
    NSString *district = [title substringWithRange:districtNo];

    NSRange buildingNo = NSMakeRange(2, 2);
    NSString *building = [title substringWithRange:buildingNo];
    
    NSRange unitNo = NSMakeRange(4, 2);
    NSString *unit = [title substringWithRange:unitNo];
    
    NSString *room = [title substringFromIndex:6];
    
    NSString *fullTitle = [NSString stringWithFormat:@"%@小区%@栋%@单元%@号房间", district, building, unit, room];
    weakSelf.title = fullTitle;
}

/**
 拼接获得轮播图数组并刷新

 @param userInfo 用户信息
 */
- (void)getBannersAndRefreshWithUserInfo:(MXUserInfoModel *)userInfo
{
    MXWeakSelf;
    // 服务器地址
    NSString *server = userInfo.server;
    // 文件夹地址
    NSString *folder = [NSString stringWithFormat:@"%@/",userInfo.advertisement.folder];
    // 拼接地址
    NSString *urlString = [server stringByAppendingString:folder];

    [weakSelf.bannersArray removeAllObjects];
    for (MXHomeBannerModel *bannerModel in userInfo.advertisement.bannerPic) {
        NSString *fullUrl = [urlString stringByAppendingString:bannerModel.name];
        [weakSelf.bannersArray addObject:fullUrl];
    }
}

- (void)loginIM
{
    NSString *IMkey = [MXComUserDefault getUserIMKey];
    NSString *IMPassword = [MXComUserDefault getUserIMPassword];
    
    // maxiao2 111
    EMError *error = [[EMClient sharedClient] loginWithUsername:IMkey password:IMPassword];
     if (!error)
     {
         NSLog(@"IM登陆成功");
     }else {
         NSLog(@"IM登录失败");
     };
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
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        return MXHomeCellHeight_Before6;
    }else {
        return MXHomeCellHeight_Later6;
    }
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
            MXSeeTalkingVC *seeTalkingVC = [[MXSeeTalkingVC alloc] init];
            seeTalkingVC.keyBagArray = self.keyBagArray;
            [self.navigationController pushViewController:seeTalkingVC animated:YES];
        }
            break;
            // 开门记录
        case 1:
        {
            MXOpenRecordVC *recordVC = [[MXOpenRecordVC alloc] init];
            recordVC.title = @"开门记录";
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
            noDisturbVC.title = @"免打扰";
            [self.navigationController pushViewController:noDisturbVC animated:YES];
        }
            break;
            // 社区互帮
        case 4:
        {
            MXCommunityControlVC *communityControlVC = [[MXCommunityControlVC alloc] init];
            communityControlVC.title = @"社区互帮";
            [self.navigationController pushViewController:communityControlVC animated:YES];
        }
            break;
            // o2o商城
        case 5:
        {
            MXO2OVC *o2oVC = [[MXO2OVC alloc] init];
            o2oVC.title = @"o2o商城";
            [self.navigationController pushViewController:o2oVC animated:YES];
        }
            break;
            // 智享体验
        case 6:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"检查到您的手机中尚未安装MohMoo智能家居，是否进行下载" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *str = [NSString stringWithFormat:
                                 @"https://itunes.apple.com/cn/app/yi-bi-fen-ji-shi-zu-qiu-bi/id1044544499?mt=8"];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertController addAction:OKAction];
            [alertController addAction:cancleAction];
            
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
            break;
            // 分享开门
        case 7:
        {
            MXShareOpenVC *shareOpenVC = [[MXShareOpenVC alloc] init];
            shareOpenVC.title = @"分享开门";
            [self.navigationController pushViewController:shareOpenVC animated:YES];
        }
            break;
        default:
            break;
    }

}

#pragma mark - SDCycleScrollViewDelegate代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"点击了%ld个按钮",(long)index);
}

#pragma mark - MXHomeLeftMenuDelegate
- (void)homeLeftMenuDidClickButtonAtIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
    }];
    switch (index) {
            // 免打扰
        case 0:
        {
            
        }
            break;
            // 修改密码
        case 1:
        {
            
        }
            break;
            // 钥匙包
        case 2:
        {
            
        }
            break;
            // 扫一扫
        case 3:
        {
            
        }
            break;
            // 关于
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 底部钥匙按钮点击
- (void)bottomBarKeyClick
{
    MXHomeKeyBagVC *keyBagVC = [[MXHomeKeyBagVC alloc] init];
    keyBagVC.keyBagArray = self.keyBagArray;
    [self presentViewController:keyBagVC animated:YES completion:nil];
}

@end
