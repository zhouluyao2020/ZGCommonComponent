//
//  UILabel+quick.h
//  ZGStudentServices
//
//  Created by zhouluyao on 8/4/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (quick)


/// text + textColor + font + textAlignment
+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/// textColor + font
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

/// textColor + font +bgColor
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor;

/// textColor + font + textAlignment
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/// textColor + font +bgColor + textAlignment
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *_Nullable)font bgColor:(UIColor *_Nullable)bgColor textAlignment:(NSTextAlignment)textAlignment;



@end

NS_ASSUME_NONNULL_END
