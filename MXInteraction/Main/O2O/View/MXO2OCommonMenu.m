//
//  MXO2OCommonMenu.m
//  MXInteraction
//
//  Created by maRk on 16/8/29.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXO2OCommonMenu.h"
#import "MXHomeHeaderMenuBtn.h"

@interface MXO2OCommonMenu()

/** 菜单按钮标题数组 */
@property (nonatomic, strong) NSArray *menuTitles;
/** 菜单按钮图片数组 */
@property (nonatomic, strong) NSArray *menuImages;
/** 按钮行数 */
@property (nonatomic, assign) NSInteger rowCount;

@end

@implementation MXO2OCommonMenu

- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles buttonImages:(NSArray *)images andRowCount:(NSInteger)rowCount
{
    if (self = [super initWithFrame:frame]) {
        _rowCount = rowCount;
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
        CGFloat buttonH = self.height / _rowCount;
        CGFloat buttonX = buttonW * (i % 2);
        CGFloat buttomY = buttonH * (i / 2);
        MXWeakSelf;
        MXHomeHeaderMenuBtn *menuBtn = [[MXHomeHeaderMenuBtn alloc] initWithFrame:CGRectMake(buttonX, buttomY, buttonW, buttonH) index:i title:self.menuTitles[i] image:self.menuImages[i] andActionBlock:^(NSInteger i) {
            [weakSelf menuButtonClick:i];
        }];
        [self addSubview:menuBtn];
    }
    
    // 竖直分割线
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(MXScreen_Width * 0.5, 0, 0.5, self.height)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:verticalLine];
    
    // 水平分割线
    for (int i = 0 ; i < _rowCount; i++) {
        UIView *horizontalView = [[UIView alloc] initWithFrame:CGRectMake(0, i * self.height / _rowCount , MXScreen_Width, 0.5)];
        horizontalView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:horizontalView];
    }
}

#pragma mark - 内部方法
- (void)menuButtonClick:(NSInteger )index
{
    if ([self.delegate respondsToSelector:@selector(MXO2OCommonMenuButtonDidClick:)]) {
        [self.delegate MXO2OCommonMenuButtonDidClick:index];
    }
}

@end
