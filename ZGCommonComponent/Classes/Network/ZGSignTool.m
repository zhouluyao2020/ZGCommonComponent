//
//  ZGSignTool.m
//  ZGCacheManagerComponent
//
//  Created by zhouluyao on 9/21/20.
//  Copyright © 2020 zhouluyao. All rights reserved.
//

#import "ZGSignTool.h"
#import <CommonCrypto/CommonDigest.h>

#import "ZGURLConst.h"

@implementation ZGSignTool

+ (NSString *)loginSignWithParams:(NSDictionary *)params {
    if (params.count == 0) {
          return nil;
      }
      NSString *signStr = @"";
      NSArray *keySortArr = [params.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
      for (int i = 0; i < keySortArr.count; i ++ ) {
          if (!params[keySortArr[i]] || [params[keySortArr[i]] isEqualToString:@""]) {
              continue;
          }
          signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"%@%@%@%@",NEWENCRYPTKEY,keySortArr[i],params[keySortArr[i]],NEWENCRYPTKEY]];
      }
      
      signStr = [self md5:signStr];
      return signStr;
}

+ (NSString *)occSignWithParams:(NSDictionary *)params {
    if (params.count == 0) {
          return nil;
      }
      NSString *signStr = @"";
      NSArray *keySortArr = [params.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
      for (int i = 0; i < keySortArr.count; i ++ ) {
          
          if (!params[keySortArr[i]] || [params[keySortArr[i]] isEqualToString:@""]) {
              continue;
          }
          signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"%@%@%@%@",NEWENCRYPTKEY,keySortArr[i],params[keySortArr[i]],NEWENCRYPTKEY]];
      }
      
      signStr = [self md5:signStr];
      return signStr;
}

//MD5加密
+ (NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[32];
    CC_MD5(cStr, strlen(cStr), digest); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD2_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD2_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

@end
