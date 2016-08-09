//
//  YCMineViewController.m
//  Code
//
//  Created by qianfeng on 16/8/5.
//  Copyright © 2016年 yaochong. All rights reserved.
// 整个界面在一个 scrollView 上面

#import "YCMineViewController.h"
#import "YCSettingViewController.h"
#import <UIImageView+YYWebImage.h>
#import "YCUserModel.h"

@interface YCMineViewController ()

//如果一个界面被加入到父视图上面 就代表已经被强引用 所以不需要再去强引用也不会释放掉 所以我们用xib拖控件 默认是weak引用
//平时我们写的时候，也尽量写成weak引用，防止有时候发生循环引用
/** scrollView*/
@property (nonatomic ,weak) UIScrollView *scrollView;

/** 内容视图 加载scrollView上面 也实现了当内容不够的时候 界面有弹性滚动效果*/
@property (nonatomic ,weak) UIView *contentView;

/** 头像*/
@property (nonatomic ,weak) UIImageView *headImageView;
/** 昵称*/
@property (nonatomic ,weak) UILabel *nickNameLabel;
/** 邮箱*/
@property (nonatomic ,weak) UILabel *emailLable;
@end

@implementation YCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setUpScrollView];
    
    [self setUpTopViews];
}

/**
 *  设置scrollView
 */
- (void)setUpScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    //背景颜色随机
    scrollView.backgroundColor = [UIColor yellowColor];
    
    //当我们使用autoLayout（不管是xib还是手写），做scrollView的约束，都要顶一个内容视图 将scrollView 撑起来
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(@0);
        
    }];
    
    
    //如果控制器里有scrollView 并且有导航条或者tabbar，系统会默认将scrollView上部留有（64）下部留有49 ，防止内容被挡住
    //但在实际做项目的时候，为了我们方便管理，会把这个特性去掉
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
    //    手动设置scrollView的insets
    scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
    self.scrollView = scrollView;
    
    
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    contentView.backgroundColor = [UIColor redColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(scrollView);
        make.width.equalTo(self.view);
        make.height.greaterThanOrEqualTo(self.view).offset(1 - 64 - 49);
        make.bottom.equalTo(scrollView);
    }];
    self.contentView = contentView;
    
   
}
/**
 *  顶部视图
 */
- (void)setUpTopViews {
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景图片"]];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@16);
        make.height.equalTo(@140);
        
    }];
    //打开bgView的用户交互
    bgView.userInteractionEnabled = YES;
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户头像"]];
    [bgView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(@16);
        make.width.height.equalTo(@48);
    }];
    self.headImageView = headImageView;
    //用户昵称
    
    UILabel *nickNameLabel = [[UILabel alloc] init];
    [bgView addSubview:nickNameLabel];
    nickNameLabel.font = [UIFont systemFontOfSize:16 weight:-0.15];
    nickNameLabel.textColor = [UIColor whiteColor];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(8);
        make.top.equalTo(@16);
        make.width.equalTo(@200);
    }];
    self.nickNameLabel = nickNameLabel;
    //用户邮箱
    UILabel *emailLabel = [[UILabel alloc] init];
    [bgView addSubview:emailLabel];
    emailLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(nickNameLabel);
        make.top.equalTo(nickNameLabel.mas_bottom).offset(4);
        make.width.equalTo(@200);
    }];
    self.emailLable = emailLabel;
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:settingBtn];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.centerY.equalTo(@0);
        make.width.equalTo(@48);
        make.height.equalTo(@32);
    }];
    
    //先完成设置界面，再完善用户资料

    [settingBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
       
        YCSettingViewController *settingVc = [[YCSettingViewController alloc] init];
        settingVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVc animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //我们将用户信息的显示写到这里，每次进到页面，可能会有更新的内容需要修改
    
    
    //1.用户刚登陆成功，然后点到这个页面
    //2.用户在设置界面修改了内容，回到这个页面
    //3.用户退出登录，又登陆另一个账户
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.30.152.134/PhalApi/Public/%@",[YCUserModel sharedUser].avatar]] placeholder:[UIImage imageNamed:@"用户头像"]];
    self.nickNameLabel.text = [YCUserModel sharedUser].nickname;
    self.emailLable.text = [YCUserModel sharedUser].email;
}
@end
























