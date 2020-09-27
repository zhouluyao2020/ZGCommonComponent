//
//  ZGNetworkStatusUtil.h
//  AFNetworking
//
//  Created by zhouluyao on 9/17/20.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGCMNetworkStatusUtil : NSObject

+ (instancetype)shareInstance;
- (BOOL)isNetworkReach;

- (AFNetworkReachabilityStatus)networkStatus;

@end

NS_ASSUME_NONNULL_END
