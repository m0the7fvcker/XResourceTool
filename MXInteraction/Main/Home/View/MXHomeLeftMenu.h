//
//  MXHomeLeftMenu.h
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXHomeLeftMenuDelegate <NSObject>

@optional

- (void)homeLeftMenuDidClickButtonAtIndex:(NSInteger)index;

@end

@interface MXHomeLeftMenu : UIView

@property (nonatomic, weak) id<MXHomeLeftMenuDelegate> delegate;

@end
