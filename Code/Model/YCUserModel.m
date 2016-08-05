//
//  YCUserModel.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCUserModel.h"

//存储用户信息的key

static NSString *userInfoKey = @"userInfoKey";
static NSString *userStatusKey = @"userStatusKey";

@implementation YCUserModel


//某个类或者分类一旦加载就会调用这个方法
+ (void)load {
    
    if([self isLogin]){
        [self loginWithInfo:[[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey]];
    }
}

/**
 *  判断是否登陆调用
 */
+ (BOOL)isLogin {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:userStatusKey];
    
}


/**
 *  登陆
 */
+ (void)loginWithInfo:(NSDictionary *)info {
    
    [[self sharedUser] yy_modelSetWithDictionary:info];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YCLogInSuccess object:nil];
     
    [self saveUserInfo:info];
}


/**
 *  注销
 */
+ (void)logOff {
    //发送登出通知
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YCLogOffSuccess object:nil];
    
    //删除本地存储的用户信息
    [self saveUserInfo:nil];
}


/**
 *  保存信息
 */
+ (void)saveUserInfo:(NSDictionary *)info {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //存储用户信息 [[self sharedUser] yy_modelToJSONObject] 过滤掉nsnull
    [userDefault setObject:[[self sharedUser] yy_modelToJSONObject] forKey:userInfoKey];
    //存储用户状态
    [userDefault setBool:!!info forKey:userStatusKey];
    
    [userDefault synchronize];
}


/**
 *  单例
 */
+ (YCUserModel *)sharedUser {
    static YCUserModel *sharedUser_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser_ = [[YCUserModel alloc] init];
        
    });
    
    return sharedUser_;
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID"  : @"id",
             };
}


@end































