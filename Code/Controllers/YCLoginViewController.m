//
//  YCLoginViewController.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCLoginViewController.h"
#import <Masonry.h>
//这个里面封装了一个方法  可以让我们通过一个颜色 生成一张纯色的图片
#import "UIButton+BackgroundColor.h"
#import "YCForgetPwdViewController.h"
#import "UIControl+ActionBlocks.h"
#import "YCRegisterViewController.h"
@interface YCLoginViewController ()

@end

@implementation YCLoginViewController


//viewDidLoad是控制器的视图已经加载完毕的时候会自动调用的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.814 alpha:1.000];
    self.title = @"登陆";
    
    //一般创建UI 都会写到viewDidLoad
    
    
    [self setupViews];
}

- (void)setupViews {
    //创建手机号码输入框，密码输入框，登陆按钮
    
    UITextField *phoneField = [[UITextField alloc] init];
    [self.view addSubview:phoneField];
    phoneField.backgroundColor = [UIColor whiteColor];
    
    UITextField *pwdField = [[UITextField alloc] init];
    [self.view addSubview:pwdField];
    pwdField.backgroundColor = [UIColor whiteColor];
    
    phoneField.placeholder = @"输入邮箱或者手机号码";
    pwdField.placeholder = @"输入密码";
    pwdField.secureTextEntry = YES;
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户图标"]];

    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码图标"]];

    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 0)];
    UIView *pwdLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 0)];
    [phoneLeft addSubview:phoneImageView];
    [pwdLeft addSubview:pwdImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(@0);
        make.height.equalTo(@23);
        make.width.equalTo(@20);
        
    }];
    [pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
        make.height.equalTo(@23);
        make.width.equalTo(@20);
    }];
    
    phoneField.leftView = phoneLeft;
    pwdField.leftView = pwdLeft;
    
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    pwdField.leftViewMode = UITextFieldViewModeAlways;
    
    //手写输入框的布局
    //在写布局的时候 我们添加的所有约束必须能过唯一确定这个视图的位置和大小
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(@120);
        make.right.left.equalTo(@0);
        //因为Masonry 在实现的时候充分考虑到我们写约束的时候越简单越好 所以引用了链式写法，所以我们在写的时候 可以尽量将一样的约束写到一起
    }];
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phoneField.mas_bottom);
    }];
    
    phoneField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    pwdField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    phoneField.layer.borderColor = [UIColor grayColor].CGColor;
    phoneField.layer.borderWidth = 0.5;
    pwdField.layer.borderWidth = 0.5;
    pwdField.layer.borderColor = [UIColor grayColor].CGColor;
    
    //忘记密码按钮
    //我们用 autoLayout 时候 就不能再以某个视图的frame 当作参数来用（此时，视图的frame 是不可靠的）
    UIButton *forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetPwdButton setFrame:CGRectMake(self.view.frame.size.width - 80, 250, 80, 64)];
    [self.view addSubview:forgetPwdButton];
    
    //登陆按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setFrame:CGRectMake(0, 320, self.view.frame.size.width, 64)];
    [self.view addSubview:loginButton];
    
    [loginButton setBackgroundColor:[UIColor greenColor]forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    //当我们不用autoLayout的时候 ，如何让视图自适应
    //autoResizing 是autoLayout之前界面自适应的工具
    //登陆按钮的宽度和左边距保持跟父控件相对位置不变
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    [forgetPwdButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
//    [forgetPwdButton addTarget:self action:@selector(goToForget) forControlEvents:UIControlEventTouchUpInside];
    //我们还可以将按钮的事件与按钮写到一块
    //1。
    [forgetPwdButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        //把按钮的事件回调写到 block 里， 便于我们在写界面的时候 方便的加入控制事件
        YCForgetPwdViewController *forgetVC = [[YCForgetPwdViewController alloc] init];
        
        [self.navigationController pushViewController:forgetVC animated:YES];
    }];
    
    
    //这里就用系统自带的
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(goToRegister)];
    
}
/**
 *  点击注册调用此方法
 */
- (void)goToRegister {
    
    YCRegisterViewController *registerVC = [[YCRegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

//界面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
//界面已经出现
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}
//界面将要消失
-  (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}
//界面已经消失
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}
@end
