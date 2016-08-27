//
//  MXPersonalHeaderBar.h
//  MXInteraction
//
//  Created by maRk on 16/8/24.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXPersonalHeaderBarDelegate <NSObject>

@required

- (void)MXPersonalHeaderBarButtonDidClick:(NSInteger)btnNumber;

@end

@interface MXPersonalHeaderBar : UIView

@property (nonatomic, weak) id<MXPersonalHeaderBarDelegate> delegate;

@end
