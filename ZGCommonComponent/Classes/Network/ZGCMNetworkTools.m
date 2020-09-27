//
//  ZGNetworkTools.m
//  ZGStudentServices
//
//  Created by offcn on 2018/11/17.
//  Copyright © 2018 cn.offcn. All rights reserved.
//

#import "ZGCMNetworkTools.h"
#import "ZGAppInfoUtil.h"
#import "ZGUserConfigManager.h"
#import "ZGURLConst.h"
#import "ZGSignTool.h"
#import "ZGNotificationConst.h"
#import <YYModel/YYModel.h>

@implementation ZGCMNetworkTools

+ (NSDictionary *)publicParameters {
    NSMutableDictionary *publicParameters = [NSMutableDictionary dictionary];
    
    publicParameters[@"php_new_123sid"] = [ZGUserConfigManager shareInstance].sessionId;
    publicParameters[@"php_new_vs"] = @"2";
    publicParameters[@"type"] = [ZGUserConfigManager type];
    publicParameters[@"v"] = [ZGAppInfoUtil appVersion];
    return [publicParameters copy];
}

//通用接口->post请求
+(void)postNormalUrl:(NSString *)url parameters:(NSMutableDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock{
    
    if ([url hasPrefix:@"http"]||[url hasPrefix:@"https"]) {
        
    }else {
        url = [NSString stringWithFormat:@"%@%@",ZG_HTTP_KAIXUE_BASIC_HOST,url];
    }
    NSMutableDictionary *mutableParameters = [self publicParameters].mutableCopy;
    if (param) {
        [mutableParameters setValuesForKeysWithDictionary:param];
    }
    if ([url containsString:@"login"]) {
        NSString *sign = [ZGSignTool loginSignWithParams:mutableParameters];
        mutableParameters[@"sign"] = sign;
    } else {
        NSString *sign = [ZGSignTool occSignWithParams:mutableParameters];
        mutableParameters[@"sign"] = sign;
    }
    if([url containsString:@"get_identity/"])
    {
        mutableParameters = nil;
    }
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *version = [ZGAppInfoUtil appVersionInfo];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"OCC-USER-AGENT"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", nil];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager POST:url parameters:mutableParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([[dic allKeys] containsObject:@"login_status"] && [dic[@"login_status"] integerValue] == 0) //登录状态为0，未登录，强制跳转登录页面
        {
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserForceLogoutNotification object:nil];
            }
        }
        if([dic[@"flag"] integerValue] != 1 && [dic[@"flag"] integerValue] != 2 && [dic[@"flag"] integerValue] != 3)
        {
            NSString *content = [NSString stringWithFormat:@"%@,%@,%@",url,mutableParameters,dic];
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self postErrorLog:content];
            }
        }
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = url;
            
            aliLogDic[@"post"] = [mutableParameters isKindOfClass:[NSDictionary class]]?[mutableParameters yy_modelToJSONString]:@"";
            aliLogDic[@"reselt"] = responseObject;
            NSURL *ipURL = [NSURL URLWithString:url];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            aliLogDic[@"server_ip"] = ipStr;
            aliLogDic[@"api_head"] = version;
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self upAliLogWithDict:aliLogDic];
            }
        });
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error.code == -1001)
        {
            NSString *content = [NSString stringWithFormat:@"%@,%@,%@",url,mutableParameters,@"请求超时"];
            [self postErrorLog:content];
        }
        else
        {
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSLog(@"%ld",(long)responses.statusCode);
            
            NSString *content = [NSString stringWithFormat:@"%@,%@,%ld",url,mutableParameters,(long)responses.statusCode];
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self postErrorLog:content];
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = url;
            aliLogDic[@"post"] = [mutableParameters isKindOfClass:[NSDictionary class]]?[mutableParameters yy_modelToJSONString]:@"";
            NSURL *ipURL = [NSURL URLWithString:url];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            if(error.code == -1001)
            {
                aliLogDic[@"reselt"] = @"请求超时";
            }
            else
            {
                NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                aliLogDic[@"reselt"] = [NSString stringWithFormat:@"%ld",(long)responses.statusCode];
            }
            aliLogDic[@"server_ip"] = ipStr;
            aliLogDic[@"api_head"] = version;
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self upAliLogWithDict:aliLogDic];
            }
        });
        failureBlock(error);
    }];
}
//通用接口->get请求
+(void)getNormalUrl:(NSString *)url parameters:(NSMutableDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock {
    NSMutableDictionary *mutableParameters = [self publicParameters].mutableCopy;
    if (param) {
        [mutableParameters setValuesForKeysWithDictionary:param];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", ZG_HTTP_KAIXUE_BASIC_HOST, url];
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    NSString *version = [ZGAppInfoUtil appVersionInfo];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"OCC-USER-AGENT"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager GET:requestUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"login_status"] integerValue] == 0) //登录状态为0，未登录，强制跳转登录页面
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserForceLogoutNotification object:nil];
        }
        if([dic[@"flag"] integerValue] != 1 && [dic[@"flag"] integerValue] != 2 && [dic[@"flag"] integerValue] != 3)
        {
            NSString *content = [NSString stringWithFormat:@"%@,%@,%@",url,mutableParameters,dic];
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self postErrorLog:content];
            }
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = requestUrl;
            aliLogDic[@"post"] = [param isKindOfClass:[NSDictionary class]]?[mutableParameters yy_modelToJSONString]:@"";
            aliLogDic[@"reselt"] = responseObject;
            NSURL *ipURL = [NSURL URLWithString:requestUrl];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            aliLogDic[@"server_ip"] = ipStr;
            aliLogDic[@"api_head"] = version;
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self upAliLogWithDict:aliLogDic];
            }
        });
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error.code == -1001)
        {
            NSString *content = [NSString stringWithFormat:@"%@,%@,%@",url,mutableParameters,@"请求超时"];
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self postErrorLog:content];
            }
        }
        else
        {
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSLog(@"%ld",(long)responses.statusCode);
            NSString *content = [NSString stringWithFormat:@"%@,%@,%ld",url,mutableParameters,(long)responses.statusCode];
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self postErrorLog:content];
            }
        }
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = url;
            aliLogDic[@"post"] = [param isKindOfClass:[NSDictionary class]]?[mutableParameters yy_modelToJSONString]:@"";
            NSURL *ipURL = [NSURL URLWithString:url];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            aliLogDic[@"server_ip"] = ipStr;
            if(error.code == -1001)
            {
                aliLogDic[@"reselt"] = @"请求超时";
            }
            else
            {
                NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                aliLogDic[@"reselt"] = [NSString stringWithFormat:@"%ld",(long)responses.statusCode];
            }
            aliLogDic[@"api_head"] = version;
            if (![url containsString:ZG_URL_Learning_Record_Upload]) {
                [self upAliLogWithDict:aliLogDic];
            }
        });
        failureBlock(error);
    }];
}
/*
 接口错误
 Content 这个字段的内容, 就传错误的url, 和返回的内容,
 is_info   这个字段传:URL_ERROR
 */
+(void)postErrorLog:(NSString *)content
{
    //手机系统版本
    NSString *phoneVersion = [NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]];
    NSString *appVersion = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary]valueForKey:@"CFBundleShortVersionString"]];
    NSString *err = [NSString stringWithFormat:@"%@",content];
    NSString *name;
    NSString *phone;
    NSString *email;
    
    if([ZGUserConfigManager shareInstance].isLogined)
    {
        name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"nickname"]];
        phone =  [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"phone"]];
        email = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]];
    }
    else
    {
        name = @"";
        phone = @"";
        email = @"";
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:err,@"content",@"iOS",@"s",phoneVersion,@"v",APPID,@"app",name,@"name",phone,@"phone",appVersion,@"app_v",email,@"email",@"offcn_app_log",@"request_type",@"URL_ERROR",@"is_info",[ZGUserConfigManager shareInstance].sessionId,@"php_new_123sid",[ZGUserConfigManager shareInstance].deviceId,@"dev_id", nil];

    AFHTTPSessionManager *manager; //创建请求
    //致空请求
    if (manager) {
        manager = nil;
    }
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //接受类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *version = [ZGAppInfoUtil appVersionInfo];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"OCC-USER-AGENT"];
    
    [manager POST:@"http://app.offcn.com/phone_api/return_url4.php" parameters:dict constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSLog(@"后台返回的数据:%@",dic);
        NSLog(@"上传成功%@",dic[@"result"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
        NSLog(@"%@",error);
    }];
}

static AFHTTPSessionManager *manager=nil;

+(AFHTTPSessionManager *)sharedSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", @"text/javascript", nil];
        [manager.requestSerializer setValue:[ZGAppInfoUtil appVersionInfo] forHTTPHeaderField:@"OCC-USER-AGENT"];
        [manager.requestSerializer setValue:[ZGUserConfigManager shareInstance].deviceId forHTTPHeaderField:@"Device-Id"];
        [manager.requestSerializer setValue:[ZGUserConfigManager shareInstance].sessionId forHTTPHeaderField:@"SID"];
        
    });
    return manager;
}

+ (void)postWithURL: (NSString *)urlStr parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    if ([urlStr hasPrefix:@"http"]||[urlStr hasPrefix:@"https"]) {
        
    }else {
        urlStr = [NSString stringWithFormat:@"%@%@",ZG_HTTP_BASIC_HOST,urlStr];
    }
    
    AFHTTPSessionManager * manager = [self sharedSessionManager];

    NSMutableDictionary *postParameter;
    if (parameters == nil) {
        postParameter = [NSMutableDictionary dictionaryWithCapacity:1];
    }else{
        postParameter = [parameters mutableCopy];
    }
    //    postParameter[@"client_type"] = CLIENT_TYPE;
    postParameter[@"v"] = [ZGAppInfoUtil appVersion];
    postParameter[@"type"] = [ZGUserConfigManager type];
    postParameter[@"php_new_vs"] = @"2";
    postParameter[@"dev_id"] = [ZGUserConfigManager shareInstance].deviceId;
    postParameter[@"php_new_123sid"] = [ZGUserConfigManager shareInstance].sessionId; //KeyString
    if ([urlStr containsString:@"login"]) {
        NSString *sign = [ZGSignTool loginSignWithParams:postParameter];
        postParameter[@"sign"] = sign;
    } else {
        NSString *sign = [ZGSignTool occSignWithParams:postParameter];
        postParameter[@"sign"] = sign;
    }

    [manager POST:urlStr parameters:postParameter progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = urlStr;
            aliLogDic[@"post"] = [postParameter isKindOfClass:[NSDictionary class]]?[postParameter yy_modelToJSONString]:@"";
            aliLogDic[@"reselt"] = responseObject;
            NSURL *ipURL = [NSURL URLWithString:urlStr];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            aliLogDic[@"server_ip"] = ipStr;
            aliLogDic[@"api_head"] = [ZGAppInfoUtil appVersionInfo];
            [self upAliLogWithDict:aliLogDic];
        });

        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *aliLogDic = [NSMutableDictionary dictionary];
            aliLogDic[@"hosturl"] = urlStr;
            aliLogDic[@"post"] = [postParameter isKindOfClass:[NSDictionary class]]?[postParameter yy_modelToJSONString]:@"";
            NSURL *ipURL = [NSURL URLWithString:urlStr];
            NSString *host = ipURL.host;
            NSString *ipStr;
            if (host) {
                ipStr = [ZGAppInfoUtil getIPFromHostName:host];
            }
            aliLogDic[@"server_ip"] = ipStr;
            if(error.code == -1001)
            {
                aliLogDic[@"reselt"] = @"请求超时";
            }
            else
            {
                NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                aliLogDic[@"reselt"] = [NSString stringWithFormat:@"%ld",(long)responses.statusCode];
            }
            aliLogDic[@"api_head"] = [ZGAppInfoUtil appVersionInfo];
            [self upAliLogWithDict:aliLogDic];
        });
        
        NSLog(@"error:%@",error);
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)param success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];;
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)param formData:(ZGFormDataBlock)formDataBlock success:(ZGHttpRequestSuccess)successBlock failure:(ZGHttpRequestFailure)failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        formDataBlock(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+(void)upAliLogWithDict:(NSMutableDictionary *)dict{
//    [[ZGAliLogManager sharedManager] uploadAliLogWithDict:dict];
}
@end
