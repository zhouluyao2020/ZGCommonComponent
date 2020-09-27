//
//  UIButton+quick.h
//  ZGStudentServices
//
//  Created by zhouluyao on 8/4/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (quick)
/// highlightedImageName + action
+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(nonnull id)target action:(nonnull SEL)action;

/// disabledImageName + action
+ (UIButton *)buttonWithImageName:(NSString *)imageName disabledImageName:(NSString *)disabledImageName target:(nonnull id)target action:(nonnull SEL)action;

/// title + titleColor + font
+ (UIButton *)buttonWithTitle:(NSString *_Nullable)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/// title + titleColor + font +action
+ (UIButton *)buttonWithTitle:(NSString *_Nullable)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(nonnull id)target action:(nonnull SEL)action;



/// title 和 image 水平对齐
/// @param title label内容
/// @param titleColor label颜色
/// @param font labelfont
/// @param imageName 图片名字
/// @param space label与图片间距
/// @param imageLeft  图片在左、图片在右
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName alignHorizontalSpace:(CGFloat)space imageLeft:(BOOL)imageLeft;

/// title 和 image 垂直对齐
/// @param title label内容
/// @param titleColor label颜色
/// @param font label font
/// @param imageName 图片名字
/// @param space label与图片间距
/// @param imageTop  图片在上、图片在下
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName alignVerticalSpace:(CGFloat)space imageTop:(BOOL)imageTop;

@end

NS_ASSUME_NONNULL_END
