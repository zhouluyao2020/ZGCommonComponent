//
//  ZGEmptyDataSetView.h
//  ZGStudentServices
//
//  Created by zhouluyao on 5/25/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZGEmptyDataSetView;
@protocol ZGEmptyDataSetViewDelegate <NSObject>

@optional
- (void)emptyDataSetView:(ZGEmptyDataSetView *)view didClickButton:(UIButton *)button;
- (void)emptyDataSetViewDidTapBackgroundView:(ZGEmptyDataSetView *)view;

@end

@interface ZGEmptyDataSetView : UIView

@property (nonatomic, strong)UIImage *image;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSAttributedString *attributedStringText;

@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, strong)UIImage *buttonImage;

/**image 和 text 间距*/
@property (nonatomic, assign) CGFloat padding1;
/**text 和 subText 间距*/
@property (nonatomic, assign) CGFloat padding2;
/**subText 和 buttonImage 间距*/
@property (nonatomic, assign) CGFloat padding3;

@property (nonatomic, weak) id<ZGEmptyDataSetViewDelegate> delegate;

@end

@interface ZGNoNetworkView : ZGEmptyDataSetView


@end

@interface ZGWebNoNetworkView : ZGEmptyDataSetView


@end

@interface ZGNoDataView : ZGEmptyDataSetView


@end

