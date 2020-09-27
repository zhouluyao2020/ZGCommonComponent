//
//  UILabel+quick.m
//  ZGStudentServices
//
//  Created by zhouluyao on 8/4/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "UILabel+quick.h"

@implementation UILabel (quick)

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel new];
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    return [self labelWithTextColor:textColor font:font bgColor:nil textAlignment:textAlignment];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor {
    return [self labelWithTextColor:textColor font:font bgColor:bgColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    return [self labelWithTextColor:textColor font:font bgColor:nil textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [self labelWithTextColor:color font:font bgColor:nil textAlignment:textAlignment];
    label.text = text;
    return label;
}


@end

