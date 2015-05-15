//
//  BaseUsedViewController.m
//  BaseFramework
//
//  Created by wendongsheng on 15/5/13.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "BaseUsedViewController.h"
#import "ViewController.h"

@interface BaseUsedViewController ()

@end

@implementation BaseUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录演示";
    self.rdv_tabBarController.tabBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

    [self setupViews];
}

- (void)setupViews{
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT/2-30-10, SCREEN_WIDTH-2*50, 30)];
    name.placeholder = @"请输入用户名";
    name.tintColor = GREEN_COLOR;
    name.backgroundColor = WHITE_COLOR;
    name.borderStyle = UITextBorderStyleNone;
    name.layer.borderColor = LIGHTGRAY_COLOR.CGColor;
    name.layer.borderWidth = 1;
    name.layer.cornerRadius = 7;
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:name];
    
    name.leftViewMode = UITextFieldViewModeAlways;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    nameLabel.font = name.font;
    nameLabel.text = @"用户:";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    name.leftView = nameLabel;
    
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT/2+10, SCREEN_WIDTH-2*50, 30)];
    password.placeholder = @"请输入密码";
    password.tintColor = GREEN_COLOR;
    password.backgroundColor = WHITE_COLOR;
    password.borderStyle = UITextBorderStyleNone;
    password.layer.borderColor = LIGHTGRAY_COLOR.CGColor;
    password.layer.borderWidth = 1;
    password.layer.cornerRadius = 7;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:password];
    
    password.leftViewMode = UITextFieldViewModeAlways;
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    passwordLabel.font = password.font;
    passwordLabel.text = @"密码:";
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    password.leftView = passwordLabel;
    
    UITextField *buttom = [[UITextField alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT-30, SCREEN_WIDTH-2*50, 30)];
//    buttom.placeholder = @"测试"
    buttom.tintColor = GREEN_COLOR;
    buttom.backgroundColor = WHITE_COLOR;
    buttom.borderStyle = UITextBorderStyleNone;
    buttom.layer.borderColor = LIGHTGRAY_COLOR.CGColor;
    buttom.layer.borderWidth = 1;
    buttom.layer.cornerRadius = 7;
    buttom.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:buttom];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(0, 0, 50, 25);
    [button setTitle:@"NEXT" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleButton{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
