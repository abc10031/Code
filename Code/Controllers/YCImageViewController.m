//
//  YCImageViewController.m
//  Code
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCImageViewController.h"

@interface YCImageViewController ()

@end

@implementation YCImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片预览";
    self.view.backgroundColor = WArcColor;
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"收藏成功");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"删除成功");
    }];
    
    return @[action1,action2];
}
@end
