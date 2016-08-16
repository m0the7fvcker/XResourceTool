//
//  MXRefresh.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIScrollView;
@class UITableView;

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, LYRefreshState) {
    /** 普通闲置状态 */
    LYRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    LYRefreshStatePulling,
    /** 正在刷新中的状态 */
    LYRefreshStateRefreshing,
    /** 即将刷新的状态 */
    LYRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    LYRefreshStateNoMoreData
};

@interface MXRefresh : NSObject

/**
 *  添加ScrollView头部刷新
 *
 *  @param ScrollView 要刷新的ScrollView
 *  @param target    刷新的target
 *  @param action    刷新的action
 */
+ (void)addHeaderRefresh:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

/**
 *  添加ScrollView头部刷新
 *
 *  @param ScrollView 要刷新的ScrollView
 *  @param block    回调方法块
 */
+ (void)addHeaderRefresh:(UIScrollView *)scrollView refreshingBlock:(void (^)())block;

/**
 *  @brief 移除头部刷新
 *
 *  @param scrollView 要刷新的ScrollView
 */
+ (void)removeHeaderRefresh:(UIScrollView *)scrollView;

/**
 *  @brief 刷新头部
 *
 *  @param scrollView 要刷新的ScrollView
 */
+ (void)refreshHead:(UIScrollView *)scrollView;

/**
 *  添加ScrollView脚部刷新
 *
 *  @param ScrollView 要刷新的ScrollView
 *  @param target    刷新的target
 *  @param action    刷新的action
 */
+ (void)addFooterRefresh:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

/**
 *  添加ScrollView脚部刷新
 *
 *  @param ScrollView 要刷新的ScrollView
 *  @param block       回调方法块
 */
+ (void)addFooterRefresh:(UIScrollView *)scrollView refreshingBlock:(void (^)())block;

/**
 *  @brief 移除脚步刷新
 *
 *  @param scrollView 要刷新的ScrollView
 */
+ (void)removeFooterRefresh:(UIScrollView *)scrollView;

/**
 *  开始头部刷新
 */
+ (void)beginHeaderRefresh:(UIScrollView *)scrollView;

/**
 *  开始尾部刷新
 */
+ (void)beginFooterRefresh:(UIScrollView *)scrollView;

/**
 *  结束头部刷新
 */
+ (void)endHeaderRefresh:(UIScrollView *)scrollView;

/**
 *  结束尾部刷新
 */
+ (void)endFooterRefresh:(UIScrollView *)scrollView;

/**
 *  隐藏尾部刷新
 */
+ (void)hideFooterRefresh:(UIScrollView *)scrollView;

/**
 *  显示尾部刷新
 */
+ (void)showFooterRefresh:(UIScrollView *)scrollView;

/**
 *  @brief 改变底部状态
 */
+ (void)setFooterState:(LYRefreshState)state scrollView:(UIScrollView *)scrollView;

@end
