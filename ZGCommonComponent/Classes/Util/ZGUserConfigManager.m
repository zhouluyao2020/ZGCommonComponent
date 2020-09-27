//
//  ZGUserConfigManager.m
//  ZGStudentServices
//
//  Created by zhouluyao on 9/15/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "ZGUserConfigManager.h"

@implementation ZGUserConfigManager

+ (instancetype)shareInstance {
    static ZGUserConfigManager *userConfigManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userConfigManager = [[ZGUserConfigManager alloc]init];
    });
    return userConfigManager;
}

+ (BOOL)allowedDownloadUseWWAN {
    BOOL allow = NO;
    NSString *isAllow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isNet"];
    if ([isAllow isEqualToString:@"1"]) {
        allow = YES;
    }
    return allow;
}

+ (BOOL)isTeacherRole {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isTeacher"];
}

+ (BOOL)isTeacherToStudentRole {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isTeacher_Student"];
}

+ (NSString *)type {
    return @"8";
}

+ (NSString *)appId {
    return @"40";
}
@end
