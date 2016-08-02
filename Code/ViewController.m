//
//  ViewController.m
//  Code
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "ViewController.h"
#import "YCNetwokTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [YCNetwokTool getDataWithParameters:@{@"service":@"UserInfo.GetInfo",@"uid":@"1"} andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"%d,%@",success,result);
    }];
 
}



@end
