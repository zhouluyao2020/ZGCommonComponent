//
//  ZGAppInfoUtil.h
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/18/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGAppInfoUtil : NSObject

+ (NSString *)bundleIdentifier;

+ (BOOL)isIPhoneXSeries;

+ (BOOL)isIpad;

+ (NSString *)appVersion;

+ (double)systemVersion;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)hotSpotStatusBarHeight;

+ (BOOL)isHotSpotConnected;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)tabBarHeight;

+ (CGFloat)safeAreaTopHeight;

+ (CGFloat)safeAreaBottomHeight;

+ (NSString *)appVersionInfo;

//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSString *)getIPFromHostName:(NSString *)hostName;


@end

NS_ASSUME_NONNULL_END
