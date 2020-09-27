//
//  UIScrollView+EmptyData.m
//  ZGStudentServices
//
//  Created by zhouluyao on 5/25/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "UIScrollView+EmptyData.h"
#import <objc/runtime.h>
#import "ZGCMNetworkStatusUtil.h"
#import <MJRefresh/MJRefresh.h>

@import WebKit;

@interface UIScrollView ()

@property (nonatomic, assign) EmptyViewType zg_emptyType;

@property (nonatomic, assign) BOOL zg_forceDisplay;

/**默认NO，在第一次系统默认reloadData无数据的情况下不显示NoDataView*/
@property (nonatomic, assign) BOOL zg_ignoreReloadCount;
/**需要接口请求的数据，会在页面加载时，数据返回之前，调用一次reloadData，如果设置有NoDataView的话，会在网络数据返回之前显示空页面
 1.为了在网络数据返回之前不显示空页面，内部实现此属性，忽略zg_reloadCount == 1时的空页面显示
 2.缓存数据加载，为了在第一次显示空页面，使用zg_reloadDataIgnoreReloadCount进行数据加载
 */
@property (nonatomic, assign) NSInteger zg_reloadCount;
@end

@implementation UIScrollView (EmptyData)
#pragma mark - NoNetWork
- (void)setZg_noNetworkActionBlock:(ZGNoNetWorkActionBlock)zg_noNetworkActionBlock{
    objc_setAssociatedObject(self, @selector(zg_noNetworkActionBlock), zg_noNetworkActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (ZGNoNetWorkActionBlock)zg_noNetworkActionBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_noNetworkAction:(SEL)zg_noNetworkAction{
    objc_setAssociatedObject(self, @selector(zg_noNetworkAction), NSStringFromSelector(zg_noNetworkAction), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (SEL)zg_noNetworkAction{
    return NSSelectorFromString(objc_getAssociatedObject(self, _cmd));
}

- (void)setZg_showNetworkView:(BOOL)zg_showNetworkView{
    objc_setAssociatedObject(self, @selector(zg_showNetworkView), @(zg_showNetworkView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zg_showNetworkView{
    NSNumber *show = objc_getAssociatedObject(self, _cmd);
    return show ? [show boolValue] : YES;
}



- (void)setZg_forceBringNoNetworkViewToFront:(BOOL)zg_forceBringNoNetworkViewToFront{
    objc_setAssociatedObject(self, @selector(zg_forceBringNoNetworkViewToFront), @(zg_forceBringNoNetworkViewToFront), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (BOOL)zg_forceBringNoNetworkViewToFront{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - NoData
- (void)setZg_noDataText:(NSString *)zg_noDataText{
    objc_setAssociatedObject(self, @selector(zg_noDataText), zg_noDataText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (NSString *)zg_noDataText{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_noDataAttributedText:(NSAttributedString *)zg_noDataAttributedText{
    objc_setAssociatedObject(self, @selector(zg_noDataAttributedText), zg_noDataAttributedText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (NSAttributedString *)zg_noDataAttributedText{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_noDataImageName:(NSString *)zg_noDataImageName{
    objc_setAssociatedObject(self, @selector(zg_noDataImageName), zg_noDataImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (NSString *)zg_noDataImageName{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_noDataButtonImageName:(NSString *)zg_noDataButtonImageName{
    objc_setAssociatedObject(self, @selector(zg_noDataButtonImageName), zg_noDataButtonImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (NSString *)zg_noDataButtonImageName{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_noDataActionBlock:(ZGNoDataActionBlock)zg_noDataActionBlock{
    objc_setAssociatedObject(self, @selector(zg_noDataActionBlock), zg_noDataActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

- (ZGNoDataActionBlock)zg_noDataActionBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZg_emptyViewTypeChangeBlock:(ZGEmptyViewTypeChangeBlock)zg_emptyViewTypeChangeBlock{
    objc_setAssociatedObject(self, @selector(zg_emptyViewTypeChangeBlock), zg_emptyViewTypeChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupEmptyDataSetSourceAndDelegate];
}

-(ZGEmptyViewTypeChangeBlock)zg_emptyViewTypeChangeBlock{
      return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Private NoData Control
- (void)setZg_forceDisplay:(BOOL)zg_forceDisplay{
    objc_setAssociatedObject(self, @selector(zg_forceDisplay), @(zg_forceDisplay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zg_forceDisplay{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZg_ignoreReloadCount:(BOOL)zg_ignoreReloadCount{
    objc_setAssociatedObject(self, @selector(zg_ignoreReloadCount), @(zg_ignoreReloadCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zg_ignoreReloadCount{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZg_reloadCount:(NSInteger)zg_reloadCount{
    objc_setAssociatedObject(self, @selector(zg_reloadCount), @(zg_reloadCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)zg_reloadCount{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setZg_emptyType:(EmptyViewType)zg_emptyType{
    objc_setAssociatedObject(self, @selector(zg_emptyType), @(zg_emptyType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (EmptyViewType)zg_emptyType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

#pragma mark - DZNEmptyDataSetSource
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    ZGEmptyDataSetView *view = nil;
    if (self.zg_emptyType == EmptyViewTypeNoNetwork) {
        view = [ZGNoNetworkView new];
    }else if (self.zg_emptyType == EmptyViewTypeNoNetworkWebView) {
        view = [ZGWebNoNetworkView new];
    }else{
        ZGNoDataView *noDataView = [ZGNoDataView new];
        noDataView.image = [UIImage imageNamed:self.zg_noDataImageName];
        
        if (self.zg_noDataAttributedText) {
            noDataView.attributedStringText = self.zg_noDataAttributedText;
        } else {
        noDataView.text = self.zg_noDataText;
        }
        noDataView.buttonImage = [UIImage imageNamed:self.zg_noDataButtonImageName];
        view = noDataView;
    }
    view.delegate = self;
    //view的宽高约束在view内部实现

    return view;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView{
    return self.zg_forceDisplay;
}

-  (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    [self setupEmptyViewType];
    self.zg_reloadCount ++;
    //有网 默认不忽略reloadCount 第一次刷新
    if (self.zg_emptyType == EmptyViewTypeNoData && self.zg_ignoreReloadCount == NO && self.zg_reloadCount == 1) {
        return NO;
    }
    
    //无网分支 但是网络未确定
    if (self.zg_emptyType != EmptyViewTypeNoData && [[ZGCMNetworkStatusUtil shareInstance] networkStatus] == AFNetworkReachabilityStatusUnknown) {
        return NO;
    }
    return YES;
}

//第三方问题点：会在reloadData之前加载emptyView
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView{
    if ([self respondsToSelector:@selector(emptyDataSetShouldBeForcedToDisplay:)]) {
        if ([self emptyDataSetShouldBeForcedToDisplay:scrollView] == NO) {
            [scrollView setContentOffset:CGPointZero animated:NO];
        }
    }
}

//第三方问题点：会把emptyView加载最底部
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView{
    if (self.zg_emptyType == EmptyViewTypeNoNetwork && self.zg_forceBringNoNetworkViewToFront) {
        UIView *noNetWorkView = nil;
        for (NSInteger i = 0; i < scrollView.subviews.count; i++) {
            UIView *view = scrollView.subviews[i];
            if ([view isKindOfClass:NSClassFromString(@"DZNEmptyDataSetView")]) {
                noNetWorkView = view;
                break;
            }
        }
        
        if (noNetWorkView) {
            [scrollView bringSubviewToFront:noNetWorkView];
        }
    }
}

#pragma mark - ZGEmptyDataSetViewDelegate
- (void)emptyDataSetView:(ZGEmptyDataSetView *)view didClickButton:(UIButton *)button{
    if (self.zg_emptyType == EmptyViewTypeNoNetwork) {
        if (self.zg_noNetworkAction && [self.delegate respondsToSelector:self.zg_noNetworkAction]) {
            [self.delegate performSelector:self.zg_noNetworkAction];
        }else if (self.zg_noNetworkActionBlock) {
            self.zg_noNetworkActionBlock();
        }
    }else{
        if (self.zg_noDataActionBlock) {
            self.zg_noDataActionBlock();
        }
    }
}

- (void)emptyDataSetViewDidTapBackgroundView:(ZGEmptyDataSetView *)view{
    if (self.zg_emptyType == EmptyViewTypeNoNetworkWebView) {
        if (self.zg_noNetworkActionBlock) {
            self.zg_noNetworkActionBlock();
        }
    }
}


#pragma mark - Private
- (BOOL)isWebView{
    if ([self isKindOfClass:NSClassFromString(@"_UIWebViewScrollView")] || [self isKindOfClass:NSClassFromString(@"WKScrollView")]) {
        return YES;
    }
    return NO;
}

- (UIView *)zg_webView{
    UIView *zg_webView = nil;
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIView *superView = self.superview;
        while (superView && ([superView isKindOfClass:[WKWebView class]] == NO && [superView isKindOfClass:[UIWebView class]] == NO)) {
            superView = superView.superview;
        }
        if ([superView isKindOfClass:[WKWebView class]]) {
            WKWebView *webView = (WKWebView *)superView;
            if (webView.scrollView == self) {
                zg_webView = webView;
            }
        }
        
        if ([superView isKindOfClass:[UIWebView class]]) {
            UIWebView *webView = (UIWebView *)superView;
            if (webView.scrollView == self) {
                zg_webView = webView;
            }
        }
    }
    return zg_webView;
}

- (void)setupEmptyViewType{
    if (self.zg_showNetworkView == NO || [[ZGCMNetworkStatusUtil shareInstance ] isNetworkReach]) {
        self.zg_emptyType = EmptyViewTypeNoData;
    }else{
        if ([self isWebView]) {
            self.zg_emptyType = EmptyViewTypeNoNetworkWebView;
        }else{
            self.zg_emptyType = EmptyViewTypeNoNetwork;
        }
    }
    if (self.zg_emptyViewTypeChangeBlock) {
        self.zg_emptyViewTypeChangeBlock(self.zg_emptyType);
    }
}

- (void)setupEmptyDataSetSourceAndDelegate{
    if (self.emptyDataSetSource == nil) {
        self.emptyDataSetSource = self;
    }
    
    if (self.emptyDataSetDelegate == nil) {
        self.emptyDataSetDelegate = self;
    }
}

#pragma mark - Public
- (void)zg_showEmptyDataSet{
    self.zg_forceDisplay = YES;
    [self reloadEmptyDataSet];
}

- (void)zg_removeEmptyDataSet{
    self.zg_forceDisplay = NO;
    self.emptyDataSetDelegate = nil;
    self.emptyDataSetDelegate = self;
}

- (void)zg_reloadDataIgnoreReloadCount{
    self.zg_ignoreReloadCount = YES;
    if ([self respondsToSelector:@selector(reloadData)]) {
        [self performSelector:@selector(reloadData)];
    }
}

- (BOOL)zg_isRefreshing{
    return (self.mj_header.isRefreshing || self.mj_footer.isRefreshing);
}

+ (void)initialize{
#ifdef __IPHONE_11_0
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    });
#endif
}

@end

@implementation UIScrollView (Refresh)

- (void)headerFooterRefreshStatusWithDataSourceCount:(NSInteger)count isNewData:(BOOL)newData hasNextPage:(BOOL)hasNext {
    if (count == 0) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        return;
    }
    
    if (newData == 1) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];//上次的状态是NoMoreData,重新下拉刷新时，mj_footer置为可刷新
    } else {
        [self.mj_footer endRefreshing];
    }
    
    if (!hasNext) {
         [self.mj_footer endRefreshingWithNoMoreData];
    }
}

@end
