//
//  MXScoreMallMenu.h
//  MXInteraction
//
//  Created by maRk on 16/8/29.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXScoreMallMenuDelegate <NSObject>

@required

- (void)MXScoreMallMenuButtonDidClick:(NSInteger)btnNumber;

@end

@interface MXScoreMallMenu : UIView

- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles andButtonImages:(NSArray *)images;

@property (nonatomic, weak) id<MXScoreMallMenuDelegate> delegate;

@end
