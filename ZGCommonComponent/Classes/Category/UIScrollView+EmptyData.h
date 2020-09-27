//
//  UIScrollView+EmptyData.h
//  ZGStudentServices
//
//  Created by zhouluyao on 5/25/20.
//  Copyright © 2020 offcn. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZGEmptyDataSetView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EmptyViewType) {
    EmptyViewTypeNoNetwork,//无网络
    EmptyViewTypeNoNetworkWebView,//网页无网络
    EmptyViewTypeNoData,//无数据
};

typedef void (^ZGNoNetWorkActionBlock)(void);
typedef void (^ZGNoDataActionBlock)(void);
typedef void (^ZGEmptyViewTypeChangeBlock)(EmptyViewType emptyViewType);

@protocol DZNEmptyDataSetSource,DZNEmptyDataSetDelegate;

@interface UIScrollView (EmptyData)<ZGEmptyDataSetViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** YES 在没有网络的时候优先显示noNetView，只有在有网的时候才会显示noDataView
 NO 只会显示noDataView
 默认 YES
 */
@property (nonatomic, assign) BOOL zg_showNetworkView;
/** 默认 NO 第三方问题点：会把emptyView加载最底部,如果需要显示scrollView在最上方设置YES */

@property (nonatomic, assign) BOOL zg_forceBringNoNetworkViewToFront;

/**无网络View，重新刷新Block，需要自动实现 注意bclock加入@weakify(self)
 @strongify(self)防止内存泄漏*/
@property (nonatomic, copy) ZGNoNetWorkActionBlock zg_noNetworkActionBlock;

@property (nonatomic, copy)ZGEmptyViewTypeChangeBlock zg_emptyViewTypeChangeBlock;

/**无网络View，刷新请求方法,常用于不需要参数的刷新*/
@property (nonatomic, assign)SEL zg_noNetworkAction;



@property (nonatomic, copy) NSString *zg_noDataText;
@property (nonatomic, copy) NSAttributedString *zg_noDataAttributedText;

@property (nonatomic, copy) NSString *zg_noDataImageName;
@property (nonatomic, copy) NSString *zg_noDataButtonImageName;
@property (nonatomic, copy) ZGNoDataActionBlock zg_noDataActionBlock;

- (void)zg_showEmptyDataSet;

- (void)zg_removeEmptyDataSet;

/**参见 内部zg_reloadCount属性说明
 使用场景：在页面加载之前设置数据源的，而且要显示空页面，调用此方法
 */
- (void)zg_reloadDataIgnoreReloadCount;

- (BOOL)zg_isRefreshing;

@end

@interface UIScrollView (Refresh)

/// 根据是否为第一页、是否存在下一页、数据源是否为空设置tableView上下拉刷新的状态
/// @param count 数据源count
/// @param newData 是否为第一页
/// @param hasNext 是否还有下一页
- (void)headerFooterRefreshStatusWithDataSourceCount:(NSInteger)count isNewData:(BOOL)newData hasNextPage:(BOOL)hasNext;

@end

NS_ASSUME_NONNULL_END
