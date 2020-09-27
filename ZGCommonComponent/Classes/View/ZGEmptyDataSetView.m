//
//  ZGEmptyDataSetView.m
//  ZGStudentServices
//
//  Created by zhouluyao on 5/25/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "ZGEmptyDataSetView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import "UILabel+quick.h"

typedef NS_ENUM(NSUInteger, ZGEmptyDataSetViewType) {
    ZGEmptyDataSetViewTypeNoNetWork,
    ZGEmptyDataSetViewTypeNoNetWorkHtml,
    ZGEmptyDataSetViewTypeNoData,
};

@interface ZGEmptyDataSetView ()
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIButton *button;

@end

@implementation ZGEmptyDataSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.padding1 = 12.f;
        self.padding2 = 15.f;
        self.padding3 = 16.f;
        
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        UIView *contentView = [UIView new];
        [self addSubview:contentView];
        _contentView = contentView;
        [contentView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(100);
        }];
        
        UIImageView *imageView = [UIImageView new];
        [contentView addSubview:imageView];
        _imageView = imageView;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(contentView);
        }];
        
        UILabel *textLabel = [UILabel labelWithTextColor:[UIColor zg_colorWithHex:0xbbbbbb] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter];
        _titleLabel = textLabel;
        [contentView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(30.f);
            make.right.equalTo(contentView).offset(-30.f);
        }];
        
        UILabel *subLabel = [UILabel labelWithTextColor:[UIColor zg_colorWithHex:0x77797D] font:[UIFont boldSystemFontOfSize:14] textAlignment:NSTextAlignmentCenter];
        subLabel.numberOfLines = 0;
        _detailLabel = subLabel;
        [contentView addSubview:subLabel];
        [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(30.f);
            make.right.equalTo(contentView).offset(-30.f);
        }];
        
        UIButton *button = [UIButton new];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        _button = button;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
        }];

    }
    return self;
}

#pragma mark - Action
- (void)buttonClick:(UIButton *)sender{
    if (_delegate && [_delegate  respondsToSelector:@selector(emptyDataSetView:didClickButton:)]) {
        [_delegate emptyDataSetView:self didClickButton:sender];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer{
    if (_delegate && [_delegate  respondsToSelector:@selector(emptyDataSetViewDidTapBackgroundView:)]) {
        [_delegate emptyDataSetViewDidTapBackgroundView:self];
    }
}

#pragma mark - Setter
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

- (void)setText:(NSString *)text{
    _text = [text copy];
    self.titleLabel.text = text;
}

- (void)setAttributedStringText:(NSAttributedString *)attributedStringText {
    self.titleLabel.attributedText = attributedStringText;
}

- (void)setDetailText:(NSString *)detailText{
    _detailText = [detailText copy];
    self.detailLabel.text = detailText;
}

- (void)setButtonImage:(UIImage *)buttonImage{
    _buttonImage = buttonImage;
    [self.button setImage:buttonImage forState:UIControlStateNormal];
}

#pragma mark - Private
- (UIView *)DZNEmptyDataSetView{

    UIView *superView = self.superview;
    Class targetClass = NSClassFromString(@"DZNEmptyDataSetView");
    while (superView && [superView isKindOfClass:targetClass] == NO) {
        superView = superView.superview;
    }
    
    if ([superView isKindOfClass:targetClass]) {
        return superView;
    }
    
    return nil;
}

#pragma mark - Layout
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    UIView *targetView = [self DZNEmptyDataSetView];
    if (self.superview) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(targetView ? : self.superview);
        }];
    }
}


- (void)updateConstraints{
    [super updateConstraints];
    
    UIImage *image = self.imageView.image;
    NSString *title = self.titleLabel.text;
    NSString *detailTitle = self.detailLabel.text;
    UIImage *buttonImage = self.button.currentImage;
    
    CGFloat padding1 = (title.length && image)?_padding1:0; //titleLabel相对之前视图的间距
    CGFloat padding2 = (detailTitle.length && (image ||title.length))?_padding2:0; //detailLabel相对之前视图的间距
    CGFloat padding3 = (buttonImage && (image ||title.length || detailTitle))?_padding1:0; //button相对之前视图的间距
    
    
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(image.size);
    }];
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_imageView.mas_bottom).offset(padding1);
        
    }];
    
    [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLabel.mas_bottom).offset(padding2);
        
    }];
    
    [_button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_detailLabel.mas_bottom).offset(padding3);
        make.size.mas_equalTo(buttonImage.size);
         make.bottom.equalTo(self->_contentView);
    }];
    
}

@end

@implementation ZGNoNetworkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"empty_nonetwork"];
        self.text = @"网络异常，请重新加载";
        self.detailText = @"";
        self.buttonImage = [UIImage imageNamed:@"empty_nonetwork_reload"];
    }
    return self;
}

@end

@implementation ZGWebNoNetworkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"empty_nonetwork_h5"];
        self.text = @"网络已断开";
        self.detailText = @"请连接网络后，点击空白刷新";
        self.buttonImage = nil;
    }
    return self;
}

@end

@implementation ZGNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

@end
