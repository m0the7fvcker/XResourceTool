//
//  MXHomeLeftMenu.m
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeLeftMenu.h"
#import "MXHomeLeftMenuBtn.h"

#define HomeLeftMenuBtnHeight_Later6 65
#define HomeLeftMenuBtnHeight_Before6 50
#define HomeLeftMenuBtnIndent 20
#define HomeLeftMenuBtnWidth MXScreen_Width * 0.8

@interface MXHomeLeftMenu()

@property (nonatomic, strong) UILabel *phoneNumber;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation MXHomeLeftMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mx_colorWithHexString:@"39495C"];
        [self initData];
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initData
{
    self.imagesArray = @[@"icon_sidebar_nodisturb", @"icon_sidebar_settings", @"icon_sidebar_lock", @"icon_sidebar_scan", @"icon_sidebar_about"];
    self.titlesArray = @[@"免打扰", @"修改密码", @"钥匙包管理", @"扫一扫", @"关于"];
}

- (void)initUI
{
    // 按钮高度适配
    CGFloat buttonHeight = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        buttonHeight = HomeLeftMenuBtnHeight_Before6;
    }else {
        buttonHeight = HomeLeftMenuBtnHeight_Later6;
    }
    
    UIView *userIconView = [[UIView alloc] initWithFrame:CGRectMake(HomeLeftMenuBtnIndent, 70, HomeLeftMenuBtnWidth, buttonHeight + 20)];
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(HomeLeftMenuBtnIndent, 70, 60, 60)];
    userIcon.image = [UIImage imageNamed:@"icon_personal_user"];
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userIcon.frame) + 15, 0, 200, userIconView.height)];
    NSString *phoneNumber = [MXComUserDefault getUserAccount];
    numberLabel.text = phoneNumber ? phoneNumber : @"未登录";
    numberLabel.textColor = [UIColor whiteColor];
    self.phoneNumber = numberLabel;
    userIcon.centerY = numberLabel.centerY;
    [userIconView addSubview:userIcon];
    [userIconView addSubview:numberLabel];
    [self addSubview:userIconView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(HomeLeftMenuBtnIndent, CGRectGetMaxY(userIconView.frame), HomeLeftMenuBtnWidth, 0.5)];
    lineView.backgroundColor = [UIColor mx_colorWithHexString:@"606D7B"];
    [self addSubview:lineView];
    
    for (int i = 0 ; i < 5; i ++) {
        NSString *image = self.imagesArray[i];
        NSString *title = self.titlesArray[i];
        MXWeakSelf;
        MXHomeLeftMenuBtn *button = [[MXHomeLeftMenuBtn alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userIconView.frame) + i * buttonHeight, HomeLeftMenuBtnWidth, buttonHeight) withTag:i image:image title:title andAction:^(NSInteger index) {
            [weakSelf didClickMenu:index];
        }];
        [self addSubview:button];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(HomeLeftMenuBtnIndent, CGRectGetMaxY(button.frame), HomeLeftMenuBtnWidth, 0.5)];
        lineView.backgroundColor = [UIColor mx_colorWithHexString:@"606D7B"];
        [self addSubview:lineView];
    }
    
    UIButton *logoutBtn = [[UIButton alloc] init];
    logoutBtn.layer.cornerRadius = 5;
    logoutBtn.backgroundColor = [UIColor mx_colorWithHexString:@"505F70"];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    self.logoutBtn = logoutBtn;
    [self addSubview:logoutBtn];
}

- (void)initConstraint
{
    // 按钮高度适配
    CGFloat buttonHeight = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        buttonHeight = HomeLeftMenuBtnHeight_Before6;
    }else {
        buttonHeight = HomeLeftMenuBtnHeight_Later6;
    }
    
    MXWeakSelf;
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(HomeLeftMenuBtnWidth - 40));
        make.height.equalTo(@(buttonHeight - 10));
        make.left.equalTo(weakSelf.mas_left).offset(30);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-100);
    }];
}

- (void)didClickMenu:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(homeLeftMenuDidClickButtonAtIndex:)]) {
        [self.delegate homeLeftMenuDidClickButtonAtIndex:index];
    }
}

- (void)logout:(UIButton *)logoutBtn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([MXComUserDefault hasLogin]) {
            [MXComUserDefault removeUserIMKey];
            [MXComUserDefault removeUserIMPassword];
            [MXComUserDefault removeUserSecretKey];
            [MXComUserDefault removeUserAccount];
            [MXComUserDefault removeUserPassword];
            [MXComUserDefault removeUserQRCode];
            [MXComUserDefault removeUserLocalDeviceSerial];
            [MXComUserDefault removeUserNoDisturbSetting];
            [MXComUserDefault setHasLogin:NO];
            [self removeOpenRecord];
            [[NSNotificationCenter defaultCenter] postNotificationName:MXNoti_Home_Logout object:nil];
        }
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:OKAction];
    [alertController addAction:cancleAction];
    
    // 不知为何不能用appdelegate的window.rootVC
    [MXApplicationAccessor.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)updatePhoneNumber
{
    NSString *phoneNumber = [MXComUserDefault getUserAccount];
    self.phoneNumber.text = [MXComUserDefault getUserAccount] ? [MXComUserDefault getUserAccount] : @"未登录";
    NSLog(@"%@",self.phoneNumber.text);
}

- (void)removeOpenRecord
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 获取要删除的路径
    NSString *deletePath = [path stringByAppendingPathComponent:@"open.record"];
    // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    BOOL isDelete = [manager removeItemAtPath:deletePath error:nil];
    NSLog(@"%d", isDelete);
}
@end
