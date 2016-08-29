//
//  MXScoreMallMenu.m
//  MXInteraction
//
//  Created by maRk on 16/8/29.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXScoreMallMenu.h"
#import "MXHomeHeaderMenuBtn.h"

@interface MXScoreMallMenu()

/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;

@end

@implementation MXScoreMallMenu

- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles andButtonImages:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        [self initDataWithTitles:titles andImages:images];
        [self initUI];
    }
    return self;
}

- (void)initDataWithTitles:(NSArray *)titles andImages:(NSArray *)images
{
    self.menuTitles = titles;
    self.menuImages = images;
}

- (void)initUI
{
    for (int i = 0 ; i < self.menuTitles.count; i++) {
        CGFloat buttonW = MXScreen_Width * 0.5;
        CGFloat buttonH = self.height / 2;
        CGFloat buttonX = buttonW * (i % 2);
        CGFloat buttomY = buttonH * (i / 2);
        MXWeakSelf;
        MXHomeHeaderMenuBtn *menuBtn = [[MXHomeHeaderMenuBtn alloc] initWithFrame:CGRectMake(buttonX, buttomY, buttonW, buttonH) index:i title:self.menuTitles[i] image:self.menuImages[i] andActionBlock:^(NSInteger i) {
            [weakSelf menuButtonClick:i];
        }];
        menuBtn.layer.borderWidth = 0.5;
        menuBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:menuBtn];
    }
}

#pragma mark - 内部方法
- (void)menuButtonClick:(NSInteger )index
{
    if ([self.delegate respondsToSelector:@selector(MXScoreMallMenuButtonDidClick:)]) {
        [self.delegate MXScoreMallMenuButtonDidClick:index];
    }
}

@end
