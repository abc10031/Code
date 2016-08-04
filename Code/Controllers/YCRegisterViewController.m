//
//  YCRegisterViewController.m
//  Code
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCRegisterViewController.h"
#import <Masonry.h>
#import "UIButton+BackgroundColor.h"
#import <SMS_SDK/SMSSDK.h>
#import "UIControl+ActionBlocks.h"

#import "NSTimer+Addition.h"
#import "NSTimer+Blocks.h"
#import "NSString+MD5.h"
#import "UIAlertView+Block.h"
@interface YCRegisterViewController ()

/** 等待时间*/
@property (nonatomic ,strong) NSNumber *waitTime;

/** 定时器*/
@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation YCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
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
//        make.height.equalTo(@23);
//        make.width.equalTo(@20);
        
    }];
    [pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
//        make.height.equalTo(@23);
//        make.width.equalTo(@20);
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
  
    
    //验证码文本框
    UITextField *passField = [[UITextField alloc] init];
    [self.view addSubview:passField];
    passField.placeholder = @"请输入验证码";
    passField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    passField.backgroundColor = [UIColor whiteColor];
    [passField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@0);
        make.top.equalTo(pwdField.mas_bottom).mas_offset(@10);
        make.height.equalTo(@48);
        
    }];
    
    UIView *passLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView *passImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [passLeft addSubview:passImageView];
    [passImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);

    }];
    passField.leftView = passLeft;
    passField.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
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
    
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setFrame:CGRectMake(0, 320, self.view.frame.size.width, 64)];
    [self.view addSubview:registerButton];
    
    [registerButton setBackgroundColor:[UIColor greenColor]forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    //当我们不用autoLayout的时候 ，如何让视图自适应
    //autoResizing 是autoLayout之前界面自适应的工具
    //登陆按钮的宽度和左边距保持跟父控件相对位置不变
    registerButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    //需求设置
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //Reactive Cocoa 处理
    
    //ReactiveCocoa 可以代替 delegate/target action /通知/KVO/..一系列iOS开发里面的数据传递方式
    //RAC 使用的是信号流的方式来处理我们的数据，无论是按钮点击事件还是输入框事件还是网络获取数据。。。都可以被当做“信号”来看待
    //我们可以观测某个信号的改变，来作相应的操作
    //RAC 还可以将多个信号合并处理、过滤某些信号、自定义一些信号，所以比较强大
    
    //RAC帮我们实现了 很多系统自带的信号 比如：文本框的变化，按钮点击。。。。
    //我们去订阅这些信号 那么当信号一旦发生变化 就会通知我们
    [phoneField.rac_textSignal subscribeNext:^(NSString * phone) {
        
        if (phone.length >= 11) {
            //当输入的手机号超过11位，直接将密码框设置为第一响应者
            [pwdField becomeFirstResponder];
            if (phone.length > 11) {
                phoneField.text = [phone substringToIndex:11];
            }
        }
    }];
    
    //我们给等待时间赋初值
    self.waitTime  = @ -1;
    
    //获取验证码按钮默认设置为NO
    rightButton.enabled = NO;
    
    
    //我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值
    //combineLatest 一堆信号的集合
    RAC(rightButton,enabled) = [RACSignal combineLatest:@[phoneField.rac_textSignal,RACObserve(self, waitTime)] reduce:^(NSString * phone , NSNumber *waitTime){
        
        return @(phone.length >= 11 && waitTime.integerValue <= 0);
    }];
    
    
    //注册按钮默认不可点
    registerButton.enabled = NO;
    //满足一下条件可点
    RAC(registerButton,enabled) = [RACSignal combineLatest:@[phoneField.rac_textSignal,pwdField.rac_textSignal,passField.rac_textSignal] reduce:^(NSString *phone ,NSString *password,NSString *veri){
        return @(phone.length >= 11 && password.length >= 6 && veri.length == 4);
    }];
    
    //添加事件
    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        
        self.waitTime = @60;
        //发送验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            
            if (error) {
                self.waitTime = @-1;
                NSLog(@"%@",error);
            }else {
                NSLog(@"获取验证码成功");
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f block:^{
                   
                        
                self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue - 1];
                    
                } repeats:YES];
            }
        }];
    }];
    
    //用RAC 监控数据的变化响应相应的界面
    [RACObserve(self, waitTime) subscribeNext:^(NSNumber *waitTime){
        
        if (waitTime.integerValue <= 0) {
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else if(waitTime.integerValue > 0){
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒",waitTime] forState:UIControlStateNormal];
        }
    }];
    
    
    
    [[registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSDictionary *params = @{
                                 @"service":@"User.Register",
                                 @"phone":phoneField.text,
                                 @"password":pwdField.text.md532BitUpper,
                                 @"verificationCode":passField.text
                                 
                                 };
        
        [YCNetwokTool getDataWithParameters:params andCompleteBlock:^(BOOL success, id result) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"取消" otherButtonTitles:nil, nil];
            }
            
        }];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
//1点击发送验证码，按钮变为不可用，发送验证码
//2如果发送成功，按钮不可用，按钮上面显示60秒倒计时
//3.如果发送失败，按钮设置为可用，提示发送失败
//4.当倒计时结束的时候，将按钮设置为可用（还要同时考虑到手机号是否符合规则）
@end
















