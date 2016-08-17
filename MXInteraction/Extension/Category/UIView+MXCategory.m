
//
//  UIView+MXCategory.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "UIView+MXCategory.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation MXBlankView
#pragma mark - 构造方法
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self addConstraint];
    }
    return self;
}

#pragma mark - 初始化UI
- (void)initUI
{
    self.clipsToBounds = YES;
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines           = 0;
    _titleLabel.preferredMaxLayoutWidth = 300;//最大宽度300
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

#pragma mark - 添加约束
-(void)addConstraint
{
    MXWeakSelf;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.mas_centerY);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_centerY).with.offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
}
@end

@implementation UIView (MXCategory)

#pragma mark - origin 坐标点
-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame   = self.frame;
    frame.origin   = origin;
    self.frame     = frame;
}

#pragma mark - size 大小
-(CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size
{
    CGRect frame   = self.frame;
    frame.size     = size;
    self.frame     = frame;
}

#pragma mark - width 宽度
-(CGFloat)width
{
    return self.size.width;
}

-(void)setWidth:(CGFloat)width
{
    CGSize size    = self.size;
    size.width     = width;
    self.size      = size;
}

#pragma mark - height 高度
-(CGFloat)height
{
    return self.size.height;
}

-(void)setHeight:(CGFloat)height
{
    CGSize size    = self.size;
    size.height    = height;
    self.size      = size;
}

#pragma mark - x 横坐标
-(CGFloat)x
{
    return self.origin.x;
}

-(void)setX:(CGFloat)x
{
    CGPoint origin = self.origin;
    origin.x       = x;
    self.origin    = origin;
}

#pragma mark - y 纵坐标
-(CGFloat)y
{
    return self.origin.y;
}

-(void)setY:(CGFloat)y
{
    CGPoint origin = self.origin;
    origin.y       = y;
    self.origin    = origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

-(MXBlankView *)blankView
{
    return objc_getAssociatedObject(self, @"blankView");
}

-(void)setBlankView:(MXBlankView *)blankView
{
    [self willChangeValueForKey:@"blankView"];
    objc_setAssociatedObject(self, @"blankView",
                             blankView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"blankView"];
    
}

#pragma mark - 空白页
- (void)showBankView:(NSString *)title imageName:(NSString *)imageName font:(UIFont *)font textColor:(UIColor *)textColor backgourndColor:(UIColor *)backgourndColor
{
    if (!self.blankView) {
        self.blankView = [[MXBlankView alloc]init];
        self.blankView.hidden = YES;
        [self addSubview:self.blankView];
        MXWeakSelf;
        [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
    }
    
    self.blankView.hidden = NO;
    
    self.blankView.titleLabel.text = title;
    self.blankView.titleLabel.textColor = textColor;
    self.blankView.titleLabel.font = font;
    self.blankView.imageView.image = [UIImage imageNamed:imageName];
    self.blankView.backgroundColor = backgourndColor;
    
}

-(void)showBankView:(NSString *)title imageName:(NSString *)imageName
{
    [self showBankView:title imageName:imageName font:MXFont(14) textColor:MXColor(@"#282B35") backgourndColor:MXColor(@"#FFFFFF")];
}

- (void)hiddenBankView
{
    if (self.blankView) {
        self.blankView.hidden = YES;
    }
}

- (UIViewController *)viewController{
    /// Finds the view's view controller.
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}
@end
