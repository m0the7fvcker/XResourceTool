//
//  MXRefresh.m
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXRefresh.h"
#import <MJRefresh/MJRefresh.h>

@implementation MXRefresh
#pragma mark - 添加ScrollView头部刷新
+ (void)addHeaderRefresh:(UIScrollView *)scrollView target:(id)target action:(SEL)action
{
    MJRefreshNormalHeader * refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    [self configureHead:refreshNormalHeader];
    scrollView.mj_header = refreshNormalHeader;
}

+ (void)addHeaderRefresh:(UIScrollView *)scrollView refreshingBlock:(void (^)())block
{
    MJRefreshNormalHeader * refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    [self configureHead:refreshNormalHeader];
    scrollView.mj_header = refreshNormalHeader;
}

#pragma mark -  配置下啦刷新文本
+ (void)configureHead:(MJRefreshStateHeader *)refreshNormalHeader
{
    //    [refreshNormalHeader setTitle:@"" forState:MJRefreshStateIdle];
    //    [refreshNormalHeader setTitle:@"" forState:MJRefreshStatePulling];
    //    [refreshNormalHeader setTitle:@"" forState:MJRefreshStateRefreshing];
    //    [refreshNormalHeader setTitle:@"" forState:MJRefreshStateWillRefresh];
    //    refreshNormalHeader.lastUpdatedTimeLabel.hidden = NO;
}

#pragma mark - 移除头部刷先
+(void)removeHeaderRefresh:(UIScrollView *)scrollView
{
    scrollView.mj_header = nil;
}

#pragma mark - 刷新头部
+(void)refreshHead:(UIScrollView *)scrollView
{
    MJRefreshStateHeader * refreshHead = (MJRefreshStateHeader *)scrollView.mj_header;
    [self configureHead:refreshHead];
}

#pragma mark - 添加ScrollView脚部刷新
+(void)addFooterRefresh:(UIScrollView *)scrollView target:(id)target action:(SEL)action
{
    MJRefreshAutoNormalFooter * footView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [self configureFoot:footView];
    scrollView.mj_footer = footView;
}

+ (void)addFooterRefresh:(UIScrollView *)scrollView refreshingBlock:(void (^)())block
{
    MJRefreshAutoNormalFooter * footView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];;
    [self configureFoot:footView];
    scrollView.mj_footer = footView;
}

#pragma mark -  配置上拉加载文本
+ (void)configureFoot:(MJRefreshAutoStateFooter *)refreshNormalFoot
{
    //    [refreshNormalFoot setTitle:@"" forState:MJRefreshStateIdle];
    //    [refreshNormalFoot setTitle:@"" forState:MJRefreshStatePulling];
    //    [refreshNormalFoot setTitle:@"" forState:MJRefreshStateRefreshing];
    //    [refreshNormalFoot setTitle:@"" forState:MJRefreshStateWillRefresh];
    //    [refreshNormalFoot setTitle:@"" forState:MJRefreshStateNoMoreData];
}

#pragma mark - 移除脚部刷新
+(void)removeFooterRefresh:(UIScrollView *)scrollView
{
    scrollView.mj_footer = nil;
}

#pragma mark - 开始刷新
+ (void)beginHeaderRefresh:(UIScrollView *)scrollView
{
    [scrollView.mj_header beginRefreshing];
}

+ (void)beginFooterRefresh:(UIScrollView *)scrollView
{
    [scrollView.mj_footer beginRefreshing];
}

+ (void)endHeaderRefresh:(UIScrollView *)scrollView
{
    [scrollView.mj_header endRefreshing];
}

+ (void)endFooterRefresh:(UIScrollView *)scrollView
{
    [scrollView.mj_footer endRefreshing];
}

#pragma mark - 隐藏刷新
+ (void)hideFooterRefresh:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = YES;
}

+ (void)showFooterRefresh:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = NO;
}

+(void)setFooterState:(LYRefreshState)state scrollView:(UIScrollView *)scrollView
{
    [scrollView.mj_footer setState:(MJRefreshState)state];
    scrollView.bounces = YES;
}
@end
