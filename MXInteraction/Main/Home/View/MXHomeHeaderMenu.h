//
//  MXHomeHeaderView.h
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXHomeHeaderMenuDelegate <NSObject>

@required

- (void)MXHomeHeaderMenuButtonDidClick:(NSInteger)btnNumber;

@end

@interface MXHomeHeaderMenu : UIView

- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles andButtonImages:(NSArray *)images;

@property (nonatomic, weak) id<MXHomeHeaderMenuDelegate> delegate;

@end
