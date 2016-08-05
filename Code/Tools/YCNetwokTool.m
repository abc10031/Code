//
//  YCNetwokTool.m
//  Code
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCNetwokTool.h"
#import <AFNetworking.h>

#ifdef DEBUG //DEBUG 是程序自带的默认存在的一个宏定义，我们平时运行都是在这种方式下

//平时我们开发时候，都会用一个单独的测试环境
static NSString *baseUrl = @"10.30.152.134/PhalApi/Public/CodeShare";

//接口列表地址
//http://10.30.152.134/PhalApi/Public/CodeShare/listAllApis

#else

static NSString *baseUrl = @"https://www.1000phone.tk";

#endif

@implementation YCNetwokTool

static AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:QFAppBaseURL]];
        
        manager.requestSerializer.timeoutInterval = 30;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/html",  @"text/xml", @"application/json", nil];
        
    });
    return manager;
    
}


+ (void)getDataWithParameters:(NSDictionary *)params andCompleteBlock:(void (^)(BOOL, id))complete {
    
    
    [[self sharedManager] POST:@"" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"response --- %@",responseObject);
        
        if ([responseObject[@"ret"] isEqualToNumber:@200]) {//没有服务错误
            
            NSDictionary *data = responseObject[@"data"];
            NSString *dataMsg = data[@"msg"];
            
            if (dataMsg.length) {//没有数据错误
                if (complete) {
                    complete(NO, dataMsg);
                }
                
            }else {
                if (complete) {
                    complete(YES, data[@"data"]);
                }
            }
            
        }else {
            
            if (complete) {
                complete(NO,responseObject[@"msg"]);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(NO,error.localizedDescription);
        }
    }];
    
    
}

//上传图片

+ (void)uploadImageData:(NSData *)imageData andParameters:(NSDictionary *)parameters completeBlock:(void (^)(BOOL, id))complete {

    
    //创建一个可变的请求 //将Data 数据拼接到请求中
    NSMutableURLRequest *uploadRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:QFAppBaseURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //在这里拼接数据
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"用户头像.jpg" mimeType:@"image/jpeg"];
        
    } error:nil];
    
    //上传
    NSURLSessionUploadTask *uploadTask = [[self sharedManager] uploadTaskWithStreamedRequest:uploadRequest progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (complete) {
                complete(NO,error.localizedDescription);
            }
        }else {
            
            NSLog(@"%@",responseObject);
        }
        
    }];
    [uploadTask resume];
}
@end
