//
//  YCSettingViewController.m
//  Code
//
//  Created by qianfeng on 16/8/5.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCSettingViewController.h"
#import "YCUserInfoViewController.h"


@interface YCSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 数据*/
@property (nonatomic ,strong) NSArray *dataArray;

@end

@implementation YCSettingViewController

static NSString *const settingCellID = @"setting";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    [self initData];
    
    [self setUpTableView];
}
/**
 *  初始化数据
 */
- (void)initData {
    
    //我们用MVC的方式去写tableView 让tableview 根据我们提前设置好的数据取展示就可以了
    
    self.dataArray = @[
                       @[
                           @{
                               @"title":@"个人信息",
                               @"subtitle":@"哈哈",
                               @"acceryType":@"arrow"
                               }
                           ],
                       @[
                           @{
                               @"title":@"允许查看我的分享",
                               @"subtitle":@"嘿嘿",
                               @"acceryType":@"switch"
                               },
                           @{
                               @"title":@"允许查看我的下载",
                               @"subtitle":@"哈哈",
                               @"acceryType":@"switch"
                               },
                           @{
                               @"title":@"任何人允许添加我为好友",
                               @"subtitle":@"哈哈",
                               @"acceryType":@"switch"
                               }
                           ],
                       @[
                           @{
                               @"title":@"保存到本地",
                               @"subtitle":@"哈哈",
                               @"acceryType":@"arrow"
                               },
                           @{
                               @"title":@"账号绑定",
                               @"subtitle":@"QQ123456",
                               @"acceryType":@"arrow"
                               }
                           ],
                       @[
                           @{
                               @"title":@"清除缓存",
                               @"subtitle":@"哈哈",
                               @"acceryType":@""
                               },
                           @{
                               @"title":@"用户反馈",
                               @"subtitle":@"QQ123456",
                               @"acceryType":@"arrow"
                               },
                           @{
                               @"title":@"关于我们",
                               @"subtitle":@"哈哈",
                               @"acceryType":@"arrow"
                               },
                          
                           ]
                       ];
}
/**
 *  设置tableView
 */
- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.sectionFooterHeight = 8;
    tableView.sectionHeaderHeight = 8;
    tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
    
    //取字典
    NSDictionary *cellInfo = self.dataArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = cellInfo[@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *cellType = cellInfo[@"acceryType"];
    
    if ([cellType isEqualToString:@"arrow"]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([cellType isEqualToString:@"switch"]) {
        
        cell.accessoryView = [[UISwitch alloc] init];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        YCUserInfoViewController *userVC = [[YCUserInfoViewController alloc] init];
        
        [self.navigationController pushViewController:userVC animated:YES];
    }
    
}
@end
