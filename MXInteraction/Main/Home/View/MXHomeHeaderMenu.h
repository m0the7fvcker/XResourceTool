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

@property (nonatomic, weak) id<MXHomeHeaderMenuDelegate> delegate;

@end
