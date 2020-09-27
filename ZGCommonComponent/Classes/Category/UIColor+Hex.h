//
//  UIColor+Hex.h
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/17/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

/// 用法：[UIColor zg_colorWithHex:0x337CC4]
+ (UIColor *)zg_colorWithHex:(UInt32)hex;

/// 用法： [UIColor zg_colorWithHex:0x999999 andAlpha:0.2]
+ (UIColor *)zg_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/// 用法： [UIColor zg_colorWithHexString:@"#337CC4"]
+ (UIColor *)zg_colorWithHexString:(NSString *)hexString;

///用法：[UIColor doraemon_colorWithString:@"#324456"]
+ (UIColor *)zg_colorWithString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
