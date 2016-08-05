//
//  YCEditNameViewController.m
//  Code
//
//  Created by qianfeng on 16/8/5.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCEditNameViewController.h"
#import "YCUserModel.h"
@interface YCEditNameViewController ()

@end

@implementation YCEditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更改姓名";
    self.view.backgroundColor = WArcColor;
    
    UITextField *nickName = [[UITextField alloc] init];
    [self.view addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@80);
        make.height.equalTo(@48);
    }];
    nickName.backgroundColor = [UIColor whiteColor];
    nickName.placeholder = @"不得超过15个字母或字符";
    //键盘的返回键
    nickName.returnKeyType = UIReturnKeyDone;
    //记住这个event
    [nickName handleControlEvents:UIControlEventEditingDidEndOnExit withBlock:^(id weakSender) {
        
        //在这里调用修改用户信息的接口
        NSDictionary *paras = @{
                                @"service":@"UserInfo.UpdateInfo",
                                @"uid":[YCUserModel sharedUser].ID,
                                @"nickname":nickName.text
                                };
        [YCNetwokTool getDataWithParameters:paras andCompleteBlock:^(BOOL success, id result) {
            
            if (success) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                
            }
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
