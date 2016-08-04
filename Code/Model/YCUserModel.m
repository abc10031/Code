//
//  YCUserModel.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCUserModel.h"

@implementation YCUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"  : @"id",
             };
}


+ (BOOL)isLogin {
    
    return [[[self sharedUser] ID] length];
    
}


+ (YCUserModel *)sharedUser {
    static YCUserModel *sharedUser_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser_ = [[YCUserModel alloc] init];

    });
    
    return sharedUser_;
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
