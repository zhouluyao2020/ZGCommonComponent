//
//  NSDate+String.h
//  ZGStudentServices
//
//  Created by zhouluyao on 7/9/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (String)

- (NSString *)weekdayStr;

//dateFormat 默认（ @"yyyy-MM-dd"） / @"yyyyMMdd" /@"yyyy/MM/dd"
- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

+ (NSString *)currentDateStr;

@end

NS_ASSUME_NONNULL_END
