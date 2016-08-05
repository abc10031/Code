//
//  YCUserInfoViewController.m
//  Code
//
//  Created by qianfeng on 16/8/5.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCUserInfoViewController.h"
#import "YCUserModel.h"
#import "YCEditNameViewController.h"

@interface YCUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 数据*/
@property (nonatomic ,strong) NSArray *dataArray;

/** 头像*/
@property (nonatomic ,weak) UIImageView *headerImageView;
@end

@implementation YCUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    self.view.backgroundColor = WArcColor;
    
    [self initData];
    
    [self setUpTableView];
}

//初始化数据
- (void)initData {
    
    self.dataArray = @[
                       @{
                           @"title":@"昵称",
                           @"class":[YCEditNameViewController class]
                           },
                       @{
                           @"title":@"性别",
                           @"class":[UIViewController class]
                           },
                       @{
                           @"title":@"出生日期",
                           @"class":[UIViewController class]
                           },
                       @{
                           @"title":@"所在地",
                           @"class":[UIViewController class]
                           }
                       ];
    
}

- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(@0);
    }];
    //头部视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    tableView.tableHeaderView = headerView;
    
    
    //头像
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户头像"]];

    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(@0);
        make.width.height.equalTo(@100);
    }];
    //给头像添加点击手势
    headerImageView.userInteractionEnabled = YES;
    [headerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editHeaderImage:)]];
    self.headerImageView = headerImageView;
    
    //底部视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    tableView.tableFooterView = footerView;
    UIButton *logOffBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerView addSubview:logOffBtn];
    [logOffBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOffBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logOffBtn setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [logOffBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [logOffBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.height.equalTo(@44);
    }];
    
    [logOffBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
       
        [YCUserModel logOff];
        
        
#warning 写到这里了##########
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.sectionFooterHeight = 8;
    tableView.sectionHeaderHeight = 8;
}

#pragma mark -- 代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *data = self.dataArray[indexPath.section];
    
    cell.textLabel.text = data[@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellInfo = self.dataArray[indexPath.section];
    
    UIViewController *editNameVc = [[cellInfo[@"class"] alloc] init];
    [self.navigationController pushViewController:editNameVc animated:YES];
}

/**
 *  点击用户头像调用此方法
 */
- (void)editHeaderImage:(UITapGestureRecognizer *)tap {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [actionSheet showInView:self.view];
}

#pragma  mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",buttonIndex);
    
    if (buttonIndex == 0) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //处理选择完成的的回调
        imagePicker.delegate = self;
        //支持图片裁剪
        imagePicker.allowsEditing = YES;
        
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }else if (buttonIndex == 1) {
        
    }
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSLog(@"%@",info);
    
    //1.将图片信息取出
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //2.将图片设置为头像
    self.headerImageView.image = editedImage;
    //3.将图片压缩上传
    
    //无损压缩
//    NSData *imageData = UIImagePNGRepresentation(editedImage);
    
    //有损压缩，一般我们去计算得到的图片文件过大，都会用有损压缩 第二个参数 0~1之间的数 越小压缩的越厉害
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.9);
    
    NSDictionary *params = @{
                             @"service":@"UserInfo.UpdateAvatar",
                             @"uid":[YCUserModel sharedUser].ID
                             };
    
    [YCNetwokTool uploadImageData:imageData andParameters:params completeBlock:^(BOOL success, id result) {
        
    }];
    
    //将控制器隐藏
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end





















