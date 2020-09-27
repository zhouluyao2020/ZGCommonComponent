//
//  NSDate+String.m
//  ZGStudentServices
//
//  Created by zhouluyao on 7/9/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)

- (NSString *)weekdayStr {
   NSInteger indexOfWeek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
    
    switch (indexOfWeek) {
           case 1:
               return @"周日";
               break;
           case 2:
               return @"周一";
               break;
           case 3:
               return @"周二";
               break;
           case 4:
               return @"周三";
               break;
           case 5:
               return @"周四";
               break;
           case 6:
               return @"周五";
               break;
           case 7:
               return @"周六";
               break;
               
           default:
               return @"";
               break;
       }
}

- (NSString *)stringWithDateFormat:(NSString *)dateFormat {
    if (dateFormat.length == 0) {
        dateFormat = @"yyyy-MM-dd";
    }
    NSLocale *chinese = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = chinese;
    dateFormatter.dateFormat = dateFormat;

    return [dateFormatter stringFromDate:self];
}

+ (NSString *)currentDateStr {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
@end
