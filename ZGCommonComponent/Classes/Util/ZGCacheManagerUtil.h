//
//  ZGCacheManagerUtil.h
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/17/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGCacheManagerUtil : NSObject


/// byte格式化为 B KB MB 方便流量查看
+ (NSString *)formatByte:(NSString *)byte;

/// 获得某个文件的大小
+(long long)fileSizeAtPath:(NSString *)filePath;

/// 检查文件路径是否存在
+(BOOL)isExistFileAtPath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
