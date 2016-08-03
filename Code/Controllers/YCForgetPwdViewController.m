//
//  YCForgetPwdViewController.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCForgetPwdViewController.h"
#import <Masonry.h>
#import "UIButton+BackgroundColor.h"
@interface YCForgetPwdViewController ()

@end

@implementation YCForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpViews];
}

- (void)setUpViews {
    
    UITextField *phoneField = [[UITextField alloc] init];
    [self.view addSubview:phoneField];
    phoneField.placeholder = @"请输入邮箱或者手机号码";
    phoneField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.top.equalTo(@120);
        make.height.equalTo(@64);
        
    }];
    
    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机邮箱图标"]];
    [phoneLeft addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
//        make.height.equalTo(@23);
//        make.width.equalTo(@20);
    }];
    phoneField.leftView = phoneLeft;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码文本框
    UITextField *passField = [[UITextField alloc] init];
    [self.view addSubview:passField];
    passField.placeholder = @"请输入验证码";
    passField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [passField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@0);
        make.top.equalTo(phoneField.mas_bottom);
        make.height.equalTo(@64);
        
    }];
    
    UIView *passLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView *passImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [passLeft addSubview:passImageView];
    [passImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
//        make.height.equalTo(@23);
//        make.width.equalTo(@20);
    }];
    passField.leftView = passLeft;
    passField.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:-0.15];
    rightButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    rightButton.layer.borderWidth = 1.0f;
    rightButton.layer.cornerRadius = 4.0f;
    rightButton.layer.masksToBounds = YES;

    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 48)];
    [rightView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.right.equalTo(@(-4));
    }];
    passField.rightView = rightView;
    passField.rightViewMode = UITextFieldViewModeAlways;
}

@end