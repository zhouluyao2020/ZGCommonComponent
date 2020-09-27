//
//  ZGAppInfoUtil.m
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/18/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import "ZGAppInfoUtil.h"
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <netdb.h>

#define IOS_CELLULAR @"pdp_ip0"
#define IOS_WIFI @"en0"
#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"
#import "ZGURLConst.h"

@implementation ZGAppInfoUtil

+ (NSString *)bundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (BOOL)isIPhoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }

    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = nil;
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            keyWindow = [[UIApplication sharedApplication].delegate window];
        } else {
            keyWindow = [UIApplication sharedApplication].windows.firstObject;
        }

        if (keyWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }

    return iPhoneXSeries;
}

+ (BOOL)isIpad {
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (double)systemVersion {
   return [[UIDevice currentDevice].systemVersion doubleValue];
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)hotSpotStatusBarHeight {
    return 20;
}

+ (BOOL)isHotSpotConnected {
    CGFloat appStatusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    return appStatusBarHeight == ([self safeAreaTopHeight] + [self hotSpotStatusBarHeight]);
}

+ (CGFloat)navigationBarHeight {
    return [self isIPhoneXSeries] ? 88 : 64;
}

+ (CGFloat)tabBarHeight {
    return [self isIPhoneXSeries] ? 83 : 49;
}

+ (CGFloat)safeAreaTopHeight {
    return [self isIPhoneXSeries] ? 44 : 20;
}

+ (CGFloat)safeAreaBottomHeight {
    return [self isIPhoneXSeries] ? 34 : 0;
}

+ (NSString *)appVersionInfo {
    return [NSString stringWithFormat:@"APPVersion:%@  iOSVersion:%.1f APPID:%@",[self appVersion],[self systemVersion],APPID];
}
//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ? @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] : @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ];

    NSDictionary *addresses = [[self class] getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
      address = addresses[key];
      if (address)
          *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

//获取所有相关IP信息
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];

    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if (!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in *)interface->ifa_addr;
            char addrBuf[MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN)];
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if (addr->sin_family == AF_INET) {
                    if (inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6 *)interface->ifa_addr;
                    if (inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if (type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getIPFromHostName:(NSString *)hostName {
    const char *host = [hostName UTF8String];
    // Get host entry info for given host
    struct hostent *remoteHostEnt = gethostbyname(host);
    if (!remoteHostEnt) {
        return nil;
    }
    // Get address info from host entry
    struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
    
    // Convert numeric addr to ASCII string
    char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
    
    return [NSString stringWithFormat:@"%s",sRemoteInAddr];
}

@end
