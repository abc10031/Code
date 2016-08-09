//
//  YCTriangleViewController.m
//  Code
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCTriangleViewController.h"
#import "YCTriangleView.h"

#import "UIView+Screenshot.h"

#import "YCDrawView.h"
@interface YCTriangleViewController ()

@end

@implementation YCTriangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"核心绘图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (id)([UIImage imageNamed:@"icon"].CGImage);

    
    //三角形
    YCTriangleView *triangelView = [[YCTriangleView alloc] init];
    triangelView.frame = CGRectMake(26, 80, 200, 200);
    triangelView.backgroundColor = [UIColor colorWithRed:0.789 green:1.000 blue:0.861 alpha:1.000];
    [self.view addSubview:triangelView];
    
    //截图
    [triangelView screenshot];
    
    YCDrawView *drawView = [[YCDrawView alloc] initWithFrame:CGRectMake(16, 300, 100, 100)];
    [self.view addSubview:drawView];
    drawView.backgroundColor = [UIColor redColor];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:dismissBtn];
    dismissBtn.frame = CGRectMake(5, 20, 100, 20);
    [dismissBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick {
    
    [self  dismissViewControllerAnimated:YES completion:nil];
}


@end
