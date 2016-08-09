//
//  YCAboutViewController.m
//  Code
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCAboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface YCAboutViewController ()<MFMessageComposeViewControllerDelegate>



@end

@implementation YCAboutViewController
{
    CTCallCenter *_callCenter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //这个界面一般都是写死的 我们用xib最好
    //会包含app的基本信息，版本、开发、和联系方式
    //打电话和发短信功能
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpButtons];
    
    //我们如何取监控手机打电话的状态，去做相应的处理
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
    [callCenter setCallEventHandler:^(CTCall * _Nonnull call) {
        
        NSLog(@"callState -- %@",call.callState);
        //在这里根据不同的状态做对应的处理
        //如果在这里，有涉及到视图的修改，要跳到主线程去做
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.view.backgroundColor = WArcColor;
        });
    }];
    //我们现在用的是ARC 如果对象不被引用会直接销毁掉，所以我们写好了处理的block，但是callCenter被释放了，应该将callcenter当作成员变量
    _callCenter = callCenter;
}

- (void)setUpButtons {
    
    NSArray *titles = @[@"打电话1",@"打电话2",@"发短信1",@"发短信2"];
    
    UIButton *lastBtn = nil;
    
    for ( int i = 0 ; i < titles.count; i++) {
        
        //取出title 创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setBackgroundColor:WArcColor forState:UIControlStateNormal];
        [button setBackgroundColor:WArcColor forState:UIControlStateHighlighted];
        [self.view addSubview:button];
        //用masonry 设置这样的button约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@16);
            make.centerX.equalTo(@0);
            make.height.equalTo(@48);
            make.top.equalTo(lastBtn ? lastBtn.mas_bottom : @0).offset(lastBtn ? 16 : 80);
        }];
        lastBtn = button;
        button.tag = i + 10;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)tapButton:(UIButton *)btn {
    
    switch (btn.tag ) {
        case 10:
        {
            //最简单 直接打给某个号码 没有提示，会造成appStore 拒绝我们的应用 建议使用case11 webView的方式 有提示
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://5454"]];
        }
            break;
        case 12:
        {
            //无法指定消息内容
            //无法群发
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://110"]];
        }
            break;
        case 11:
        {
            //我们可以用webView来打电话
            //这种方式，打完电话可以直接回到我们的应用
            //在拨出去之前，会给用户一个提示
            UIWebView *webView = [[UIWebView alloc] init];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://3343"]]];
            [self.view addSubview:webView];
            
            //这里webView 最好用懒加载的方式 因为每次都是创建一个新的webView
        }
            break;
        case 13:
        {
            MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
            //这种方式发短信，可以指定内容和群发
            //如果应用的用户有iPad 或 iPod 这个适配一定要做
            
            if ([MFMessageComposeViewController canSendText]) {
                
                messageVC.body = @"dafdadfadfa说的飒飒大师";
                messageVC.recipients = @[@"119",@"120",@"110"];
                messageVC.messageComposeDelegate = self;
                [self presentViewController:messageVC animated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
    
    //一般iOSapp直接应用传值都是使用这种方式，一个app一旦定义了自己的scheme，那么其他的app就可以直接打开，我们在appDelegate中可以根据传来的不同参数执行不同的功能。
    //在iOS9之后，我们想要打开其他的app，需要经过用户同意才可以，并且需要现在plist文件中配置好对方app的scheme
    //我们还可以通过这种方式去收集用户手机中都安装了哪些app
    //QQ
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tencent://"]];
    //微信
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
}
#pragma  mark -- <MFMessageComposeViewController>
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    //不管是成功还是隐藏，现将控制器隐藏
    [controller dismissViewControllerAnimated:YES completion:nil];
    /**
     *  
     enum MessageComposeResult {
     MessageComposeResultCancelled,
     MessageComposeResultSent,
     MessageComposeResultFailed
     };
     */
    NSLog(@"%d",result);
    //群发人数不要超过50人 否则会卡到跳转的时候
}

@end
