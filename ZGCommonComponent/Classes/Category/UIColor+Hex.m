//
//  UIColor+Hex.m
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/17/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import "UIColor+Hex.h"

CGFloat zgColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (Hex)

+ (UIColor *)zg_colorWithHex:(UInt32)hex{
    return [UIColor zg_colorWithHex:hex andAlpha:1];
}

+ (UIColor *)zg_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)zg_colorWithString:(NSString *)hexString{
    return [self zg_colorWithHexString:hexString];
}

+ (UIColor *)zg_colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = zgColorComponentFrom(colorString, 0, 1);
            green = zgColorComponentFrom(colorString, 1, 1);
            blue  = zgColorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = zgColorComponentFrom(colorString, 0, 1);
            red   = zgColorComponentFrom(colorString, 1, 1);
            green = zgColorComponentFrom(colorString, 2, 1);
            blue  = zgColorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = zgColorComponentFrom(colorString, 0, 2);
            green = zgColorComponentFrom(colorString, 2, 2);
            blue  = zgColorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = zgColorComponentFrom(colorString, 0, 2);
            red   = zgColorComponentFrom(colorString, 2, 2);
            green = zgColorComponentFrom(colorString, 4, 2);
            blue  = zgColorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
