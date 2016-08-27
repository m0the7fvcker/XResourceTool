//
//  MXPersonalHeaderBar.m
//  MXInteraction
//
//  Created by maRk on 16/8/24.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXPersonalHeaderBar.h"
#import "MXPersonalBarButton.h"

@interface MXPersonalHeaderBar()

@property (nonatomic, strong) NSArray <NSString *> *menuTitle;
@end
@implementation MXPersonalHeaderBar

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData
{
    self.menuTitle = @[@"余额",
                      @"积分",
                      @"金豆",
                      @"消息"];
}

- (void)initUI
{
    for (int i = 0 ; i < 4; i++) {
        // 创建菜单按钮
        CGFloat btnWidth = MXScreen_Width / 4;
        CGFloat btnHeight = btnWidth;
        CGFloat btnX = btnWidth * (i % 4);
        CGFloat btnY = btnHeight * (i / 4);
        CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        
        MXWeakSelf;
        MXPersonalBarButton *barBtn = [[MXPersonalBarButton alloc] initWithFrame:frame index:i title:self.menuTitle[i] andActionBlock:^(NSInteger index) {
            [weakSelf menuButtonClick:index];
        }];
        [self addSubview:barBtn];
    }
}

#pragma mark - 内部方法
- (void)menuButtonClick:(NSInteger )index
{
    if ([self.delegate respondsToSelector:@selector(MXPersonalHeaderBarButtonDidClick:)]) {
        [self.delegate MXPersonalHeaderBarButtonDidClick:index];
    }
}

@end
