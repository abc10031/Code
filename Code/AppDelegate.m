//
//  AppDelegate.m
//  Code
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>

#import "YCTabBarController.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   //当我们把main.storyboard 关联去除掉，那么打开app只会展示一个黑色的window ，没有控制器，我们需要手动创建
    
    [self setupWindow];
    //一般情况下 为了防止AppDelegate 方法里面需要添加的东西过多，显得程序混乱，我们会将不同的模块封装起来
    
    
    //Mob 初始化
    [self setupMob];
    
    //封装检测新版本
    [self setupNewVersion];
    
    [self setupShortKeys];
    
    return YES;
}

- (void)setupShortKeys {
    
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"type1" localizedTitle:@"按钮一" localizedSubtitle:@"我是小图标1" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"type2" localizedTitle:@"按钮二" localizedSubtitle:@"我是小图标2" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"type3" localizedTitle:@"按钮三" localizedSubtitle:@"我是小图标3" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause] userInfo:nil];
    
    [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3]];
    
    //如果使用这种方式，我们可以随时在app运行的时候，动态修改我们的快捷方式
    //还可以info.plist 文件中线指定一个快捷键（优先级最低），这样的话，我们的app从appStore一按装，不用运行就可以进入
}

- (void)setupNewVersion {
    
    //1.不能在界面直接展示
    
    //2.保证送审期间不能弹出新版本提示（由服务器控制）
    NSDictionary *params = @{@"service":@"Version.GetLatestVersion"};
    [YCNetwokTool getDataWithParameters:params andCompleteBlock:^(BOOL success, NSDictionary* result) {
        if (success) {
            //取出最新的版本号
            NSInteger latestVersion = [result[@"version"] integerValue];
            //取出当前版本号
            NSInteger nowVersion = [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] integerValue];
            if (nowVersion < latestVersion) {
                //对比，如果当前版本比最新版本低，就弹出警示框
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:result[@"content"] delegate:self cancelButtonTitle:[result[@"isForce"] isEqualToString:@"1"] ? @"我知道" : nil otherButtonTitles:@"去更新", nil];
                [alert show];
            }
        }
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //这里跳转到appStore
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:<#(nonnull NSString *)#>]]
    
}
- (void)setupMob {
    
    [SMSSDK registerApp:MobApp withSecret:MobSecret];
}

- (void)setupWindow {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[YCTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    //当用户通过点击桌面上图标的快捷按钮进入到app会先调用这个方法，我们可以在这里作相应的处理
    //判断是从哪个按钮进来的
    NSString *type = shortcutItem.type;
    //type 是可以标记某个item的方式之一
    
    if ([type isEqualToString:@"type2"]) {
        
        [(YCTabBarController *)[self window].rootViewController setSelectedIndex:3];
    }
    
    //userInfo 可以在用户打开app的时候传值
    
}

@end
