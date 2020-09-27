//
//  UIButton+quick.m
//  ZGStudentServices
//
//  Created by zhouluyao on 8/4/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "UIButton+quick.h"

@implementation UIButton (quick)

+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightedImageName:(nonnull NSString *)highlightedImageName target:(nonnull id)target action:(nonnull SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highlightedImageName.length) {
        [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName disabledImageName:(NSString *)disabledImageName target:(nonnull id)target action:(nonnull SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (disabledImageName.length) {
        [button setImage:[UIImage imageNamed:disabledImageName] forState:UIControlStateDisabled];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithImage:nil title:title titleColor:titleColor font:font];
}

+ (UIButton *)buttonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *button = [self new];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }

    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *_Nullable)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(nonnull id)target action:(nonnull SEL)action {
    UIButton *button = [self buttonWithTitle:title titleColor:titleColor font:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName alignHorizontalSpace:(CGFloat)space imageLeft:(BOOL)imageLeft {
    if (title.length == 0 || imageName.length == 0)
        nil;

    UIButton *button = [self buttonWithImage:[UIImage imageNamed:imageName] title:title titleColor:titleColor font:font];

    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets contentEdgeInsets = UIEdgeInsetsZero;

    CGFloat edgeOffset = space * 0.5;
    if (imageLeft) {
        imageEdgeInsets = UIEdgeInsetsMake(0, -edgeOffset, 0, edgeOffset);
        titleEdgeInsets = UIEdgeInsetsMake(0, edgeOffset, 0, -edgeOffset);
    } else {
        CGSize imageSize = [UIImage imageNamed:imageName] ? [UIImage imageNamed:imageName].size : CGSizeZero;
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];

        imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + edgeOffset, 0, -titleSize.width - edgeOffset);
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width - edgeOffset, 0, imageSize.width + edgeOffset);
    }
    contentEdgeInsets = UIEdgeInsetsMake(0, edgeOffset, 0, edgeOffset);

    button.imageEdgeInsets = imageEdgeInsets;
    button.titleEdgeInsets = titleEdgeInsets;
    button.contentEdgeInsets = contentEdgeInsets;

    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName alignVerticalSpace:(CGFloat)space imageTop:(BOOL)imageTop {
    UIButton *button = [self buttonWithImage:[UIImage imageNamed:imageName] title:title titleColor:titleColor font:font];

    CGSize imageSize = [UIImage imageNamed:imageName] ? [UIImage imageNamed:imageName].size : CGSizeZero;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];

    CGFloat imageVerticalOffset = (titleSize.height + space) * 0.5;
    CGFloat titleVerticalOffset = (imageSize.height + space) * 0.5;
    CGFloat imageHorizontalOffset = (titleSize.width) * 0.5;
    CGFloat titleHorizontalOffset = (imageSize.width) * 0.5;
    CGFloat sign = imageTop ? 1 : -1;
    CGFloat edgeOffset = (MIN(imageSize.height, titleSize.height) + space) * 0.5;

    button.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalOffset * sign, imageHorizontalOffset, imageVerticalOffset * sign, -imageHorizontalOffset);
    button.titleEdgeInsets = UIEdgeInsetsMake(titleVerticalOffset * sign, -titleHorizontalOffset, -titleVerticalOffset * sign, titleHorizontalOffset);
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0, edgeOffset, 0);

    return button;
}

@end
