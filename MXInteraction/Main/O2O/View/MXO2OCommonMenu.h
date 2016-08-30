//
//  MXO2OCommonMenu.h
//  MXInteraction
//
//  Created by maRk on 16/8/29.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXO2OCommonMenuDelegate <NSObject>

@required

- (void)MXO2OCommonMenuButtonDidClick:(NSInteger)btnNumber;

@end

@interface MXO2OCommonMenu : UIView

- (instancetype)initWithFrame:(CGRect)frame withButtonTitles:(NSArray *)titles buttonImages:(NSArray *)images andRowCount:(NSInteger)rowCount;

@property (nonatomic, weak) id<MXO2OCommonMenuDelegate> delegate;

@end
