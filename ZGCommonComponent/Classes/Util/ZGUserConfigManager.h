//
//  ZGUserConfigManager.h
//  ZGStudentServices
//
//  Created by zhouluyao on 9/15/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGUserConfigManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,   copy) NSString *sessionId;
@property (nonatomic,   copy) NSString *deviceId;
@property(nonatomic, assign) BOOL isLogined;
/// 是否允许流量下载
+ (BOOL)allowedDownloadUseWWAN;

/// 是否为老师角色
+ (BOOL)isTeacherRole;

+ (NSString *)type;
@end

NS_ASSUME_NONNULL_END
