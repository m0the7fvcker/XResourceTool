//
//  YBFYZCollectionView.m
//  YiBiFen_CN
//
//  Created by caohuihui on 16/3/30.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import "YBFYZCollectionView.h"

@implementation YBFYZCollectionView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [self required:otherGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
   return [self required:otherGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [self required:otherGestureRecognizer];
}

-(BOOL)required:(UIGestureRecognizer *)otherGestureRecognizer{
    if(self.contentOffset.x) {
        return NO;
    }
    
    if([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        return YES;
    }
    return NO;
}
@end
