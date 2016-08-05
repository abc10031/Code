//
//  YCTabBarController.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCTabBarController.h"
#import "YCMainViewController.h"
#import "YCUserModel.h"
#import "YCLoginViewController.h"
#import "YCMineViewController.h"

@interface YCTabBarController ()

@end

@implementation YCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //将所有的控制器按照MVC的思想配置好，并且封装起来
    [self setupViewControllers];
    
    //设置界面显示样式
    [self setUpAppearance];
}

- (void)setUpAppearance {
    
    //文本框光标的颜色
//    [[UITextField appearance] setTintColor:[UIColor greenColor]];
    //背景色
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.990 green:1.000 blue:0.945 alpha:1.000]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.323 green:1.000 blue:0.529 alpha:1.000]];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //当用户没有登录的时候，需要弹出登陆界面
    if (![YCUserModel isLogin]) {
        
        [self showLoginViewController];
    }
}



/**
 *  添加子控制器
 */
- (void)setupViewControllers {
    //如何使用 MVC 的思想
    
    NSArray *controllerInfos = @[
                                 //数组里面每个条目都是一个字典，里面配置了所有控制器现实的效果和类型
                                 @{
                                     @"class":[YCMainViewController class],
                                     @"title":@"首页",
                                     @"icon":@"按钮主页"
                                     
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"首页",
                                     @"icon":@"按钮消息"
                                     
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"首页",
                                     @"icon":@"按钮分享"
                                     
                                     },
                                 @{
                                     @"class":[YCMineViewController class],
                                     @"title":@"我的",
                                     @"icon":@"按钮我的"
                                     
                                     },
                                 
                                 ];
    
    //用来装控制器
    NSMutableArray *viewControlles = [NSMutableArray array];
    
    //数组枚举遍历
    [controllerInfos enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        //这里直接拿遍历 block 过来的字典，取出其中的控制器类型，然后创建一个控制器
        UIViewController *vc = [[[obj objectForKey:@"class"] alloc] init];
        
        
        vc.title = [obj objectForKey:@"title"];
        
        vc.tabBarItem.image = [UIImage imageNamed:[obj objectForKey:@"icon"]];
        
        //再创建一个导航控制器，装入刚才创建的控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        //需要将导航控制器装入到数组中
        
        [viewControlles addObject:nav];
    }];
    
    //配置tabBar控制器数组
    self.viewControllers = viewControlles;
    
}


- (void)showLoginViewController {
    
    YCLoginViewController *loginVC = [[YCLoginViewController alloc] init];
    
    //一般我们在使用模态视图是，都会用导航控制器包装一下
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    //模态弹出登陆控制器
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
