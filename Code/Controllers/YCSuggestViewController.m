//
//  YCSuggestViewController.m
//  Code
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCSuggestViewController.h"

@interface YCSuggestViewController ()

@end

@implementation YCSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"反馈";
    
    //弹好评框
    
    //点击好评，直接调到AppStore，让用户打分
    //点击差评，直接跳转到反馈页面，让用户直接反馈给我们
    //点击“以后再说”，降低弹框的频率
}
@end
