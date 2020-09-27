//
//  ZGNetworkTools.h
//  ZGStudentServices
//
//  Created by offcn on 2018/11/17.
//  Copyright © 2018 cn.offcn. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^ZGHttpRequestSuccess)(id responseObject);
typedef void(^ZGHttpRequestFailure)(NSError *error);
typedef void(^ZGFormDataBlock)(id<AFMultipartFormData>  _Nonnull formData);

NS_ASSUME_NONNULL_BEGIN

@interface ZGCMNetworkTools : AFHTTPSessionManager

//通用接口->post请求
+(void)postNormalUrl:(NSString *)url parameters:(NSMutableDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock;
//通用接口->get请求
+(void)getNormalUrl:(NSString *)url parameters:(NSMutableDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock;
//19请求接口
+ (void)postWithURL: (NSString *)urlStr parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

//学员签到
+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock;

+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)param formData:(ZGFormDataBlock)formDataBlock success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock;

//#warning - 临时使用
////通用接口->点评列表post请求
//+(void)postCommentNormalUrl:(NSString *)url parameters:(NSMutableDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock;
@end

NS_ASSUME_NONNULL_END
