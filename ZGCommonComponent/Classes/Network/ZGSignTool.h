//
//  ZGSignTool.h
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/21/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGSignTool : NSObject

/// 登录加密
+ (NSString *)loginSignWithParams:(NSDictionary *)params;

/// OCC加密
+ (NSString *)occSignWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
