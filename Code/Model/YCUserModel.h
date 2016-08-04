//
//  YCUserModel.h
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCUserModel : NSObject

/** 地址*/
@property (nonatomic ,copy) NSString *address;
/** 头像*/
@property (nonatomic ,copy) NSString *avatar;
/** 生日*/
@property (nonatomic ,copy) NSString *birthday;
/** 邮箱*/
@property (nonatomic ,copy) NSString *email;
/** 性别*/
@property (nonatomic ,copy) NSString *gender;
/** id*/
@property (nonatomic ,copy) NSString *ID;
/** 名字*/
@property (nonatomic ,copy) NSString *name;
/** 别名*/
@property (nonatomic ,copy) NSString *nickname;
/** 电话号码*/
@property (nonatomic ,copy) NSString *phone;


//我们通常都将用户当做一个model来判断 那么用户是否登录，就需要我们封装一个方法
//为什么是类方法？
//因为在我们的程序整个生命周期内，很可能只会创建一个用户对象
+ (BOOL)isLogin;

+ (YCUserModel *)sharedUser;
@end
