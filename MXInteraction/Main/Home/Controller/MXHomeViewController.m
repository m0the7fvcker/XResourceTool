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

#import "MXSeeTalkingVC.h"
#import "MXOpenRecordVC.h"
#import "MXNoDisturbVC.h"
#import "MXPersonalCenterVC.h"
#import "MXCommunityControlVC.h"
#import "MXO2OVC.h"
#import "MXShareOpenVC.h"

#import "MXHomeElevatorVC.h"
#import "MXHomeServiceVC.h"

#import "MXHttpRequest+LoginAndRegister.h"
#import "MXComUserDefault.h"
#import "MXUserInfoModel.h"
#import "MXHomeBannerModel.h"

#define MXHomeMenuHeight MXScreen_Width/2
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
/** 用户信息模型 */
@property (nonatomic, strong) MXUserInfoModel *userInfoModel;
/** 轮播图图片数组 */
@property (nonatomic, strong) NSMutableArray *bannersArray;
/** 顶部header */
@property (nonatomic, strong) UIView *headerView;
/** 钥匙包 */
@property (nonatomic, strong) NSArray *keyBagArray;

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
    [self initData];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
    [self initEMClientTool];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self makeRequest];
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
        
        // 菜单按钮
        MXHomeHeaderMenu *menuView = [[MXHomeHeaderMenu alloc] initWithFrame:CGRectMake(0, MXHomeCycleHeight, MXScreen_Width, MXHomeMenuHeight) withButtonTitles:self.menuTitles andButtonImages:self.menuImages];
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
    MXPersonalCenterVC *personCenterVC = [[MXPersonalCenterVC alloc] init];
    [self.navigationController pushViewController:personCenterVC animated:YES];
}

/**
 消息
 */
- (void)messageClick
{
    
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
    [MXHttpRequest LoginWithPhoneNumber:account password:password appVersion:@"1-1" success:^(MXBaseDataModel * _Nonnull responseModel) {
        if (responseModel.status == MXRequestCode_Success) {
            NSLog(@"请求成功");
            weakSelf.userInfoModel = [MXUserInfoModel mx_objectWithKeyValues:responseModel.data];
            // 保存secretKey到本地，部分请求续将参数添加到请求头
            if (weakSelf.userInfoModel.secretKey) [MXComUserDefault saveUserSecretKey:weakSelf.userInfoModel.secretKey];
            // 保存imKey
            if (weakSelf.userInfoModel.imKey) [MXComUserDefault saveUserIMKey:weakSelf.userInfoModel.imKey];
            // 保存imPassword
            if (weakSelf.userInfoModel.imPassword) [MXComUserDefault saveUserIMPassword:weakSelf.userInfoModel.imPassword];
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
}

/**
 请求道轮播图数据后再添加图片
 */
- (void)updateTableViewHeader
{
//        UIImage *image1 = [UIImage imageNamed:@"home_banner1.png"];
//        UIImage *image2 = [UIImage imageNamed:@"home_banner2.png"];
//        UIImage *image3 = [UIImage imageNamed:@"home_banner3.png"];
//        NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:image1, image2, image3, nil];
    MXWeakSelf;
    // 顶部轮播图
    SDCycleScrollView *cycleView         = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MXScreen_Width, MXHomeCycleHeight) imageURLStringsGroup:self.bannersArray];
    cycleView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    cycleView.autoScrollTimeInterval     = 3.0f;
    cycleView.pageControlStyle           = SDCycleScrollViewPageContolStyleClassic;
    cycleView.delegate                   = self;
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
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:@"maxiao2" password:@"111"];
     if (!error)
     {
         NSLog(@"登陆成功");
     }else {
         NSLog(@"登录失败");
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
