//
//  ZGNetworkStatusUtil.m
//  AFNetworking
//
//  Created by zhouluyao on 9/17/20.
//

#import "ZGCMNetworkStatusUtil.h"

@interface ZGCMNetworkStatusUtil ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation ZGCMNetworkStatusUtil

+ (instancetype)shareInstance {
    static ZGCMNetworkStatusUtil *networkInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkInstance = [[ZGCMNetworkStatusUtil alloc]init];
    });
    return networkInstance;
}

-(instancetype)init {
    if (self = [super init]) {
        _manager = [AFNetworkReachabilityManager sharedManager];
        [_manager startMonitoring];
    }
    return self;
}

- (BOOL)isNetworkReach {
    return _manager.isReachable;
}

- (AFNetworkReachabilityStatus)networkStatus {
    return _manager.networkReachabilityStatus;
}

@end
