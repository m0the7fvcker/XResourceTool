//
//  MXHomeHeaderView.m
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeHeaderMenu.h"
#import "MXHomeHeaderMenuBtn.h"

@interface MXHomeHeaderMenu()

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) NSArray <NSString *> *menuTitles;
@property (nonatomic, strong) NSArray <NSString *> *menuImages;

@end

@implementation MXHomeHeaderMenu

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles andButtonImages:(NSArray *)images
{
    if (self == [super initWithFrame:frame]) {
        [self initDataWithTitles:titles andImages:images];
        [self initUI];
    }
    return self;
}

- (void)initDataWithTitles:(NSArray *)array andImages:(NSArray *)images
{
    self.menuImages = images;
    self.menuTitles = array;
}

- (void)initUI
{
    CGFloat margin = 5;
    for (int i = 0 ; i < self.menuTitles.count; i++) {
        // 创建菜单按钮
        CGFloat btnWidth = (MXScreen_Width - 4 * margin) / 3;
        CGFloat btnHeight = btnWidth;
        CGFloat btnX = (btnWidth + margin) * (i % 3) + margin;
        CGFloat btnY = (btnHeight + margin) * (i / 3) + margin;
        CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        
        MXWeakSelf;
        MXHomeHeaderMenuBtn *menuBtn = [[MXHomeHeaderMenuBtn alloc] initWithFrame:frame index:i title:self.menuTitles[i] image:self.menuImages[i] andActionBlock:^(NSInteger index) {
            [weakSelf menuButtonClick:index];
        }];
        
        switch (i) {
                case 0:
            {
                menuBtn.backgroundColor = [UIColor mx_colorWithHexString:@"ecf9eb"];
            }
                break;
                case 1:
            {
                menuBtn.backgroundColor = [UIColor mx_colorWithHexString:@"e9f4fe"];
            }
                break;
                case 2:
            {
                menuBtn.backgroundColor = [UIColor mx_colorWithHexString:@"fdf0f0"];
            }
                break;
                case 3:
            {
                menuBtn.backgroundColor = [UIColor mx_colorWithHexString:@"ecf1f7"];
            }
                break;
            default:
                break;
        }
        [self addSubview:menuBtn];
    }
}

#pragma mark - 内部方法
- (void)menuButtonClick:(NSInteger )index
{
    if ([self.delegate respondsToSelector:@selector(MXHomeHeaderMenuButtonDidClick:)]) {
        [self.delegate MXHomeHeaderMenuButtonDidClick:index];
    }
}
@end
