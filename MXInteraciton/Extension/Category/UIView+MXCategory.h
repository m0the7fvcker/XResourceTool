//
//  UIView+MXCategory.h
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXBlankView : UIView
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@interface UIView (MXCategory)

@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize  size;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@property (nonatomic,strong)  MXBlankView * blankView;
- (void)showBankView:(NSString *)title imageName:(NSString *)imageName font:(UIFont *)font textColor:(UIColor *)textColor backgourndColor:(UIColor *)backgourndColor;


- (void)showBankView:(NSString *)title imageName:(NSString *)imageName;
- (void)hiddenBankView;

/*
 根据view 找出所在的Controller
 **/
- (UIViewController *)viewController;
@end
