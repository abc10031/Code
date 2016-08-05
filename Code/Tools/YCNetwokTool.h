//
//  YCNetwokTool.h
//  Code
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCNetwokTool : NSObject

//需求分析
//我们一般在网络请求数据，需要什么？
//网址 参数对
//我们想要得到什么
//请求到的数据

//因为网络请求是异步操作，所以我们获取到的数据不能直接返回，要用block回调

//这里面没有失败的回调 我们有可能需要在外边处理失败后的动作
//我们这个类仅仅是个帮助类，不需要具体的对象去做某件事

//如果我们需要请求失败的回调，具体需要什么东西

//1.成功还是失败 2.失败的原因

//我们可以封装成想AFNetworking那样成功和失败分别走两个block
+ (void)getDataWithParameters:(NSDictionary *)params andCompleteBlock:(void(^)(BOOL success,id result))complete;

//上传图片

+ (void)uploadImageData:(NSData *)imageData andParameters:(NSDictionary *)parameters completeBlock:(void(^)(BOOL success, id result))complete;
@end
