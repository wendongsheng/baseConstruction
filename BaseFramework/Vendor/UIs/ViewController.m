//
//  ViewController.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/14.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "WDTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.rdv_tabBarController.tabBarHidden = YES;
    self.title = @"练习键盘遮挡问题";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = CLEAR_COLOR;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 10; i++) {
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(20, 67+i*(20+30), SCREEN_WIDTH-20*2, 30)];
        text.backgroundColor = WHITE_COLOR;
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.placeholder = @"test avoid keyboard";
        [scrollView addSubview:text];
    }
    
    UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
    click.frame = CGRectMake(0, 0, 60, 60);
    [click setTitle:@"点击我" forState:UIControlStateNormal];
    [click addTarget:self action:@selector(handleEditButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [click setTitleColor:RED_COLOR forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:click];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)handleEditButtonAction{
    WDTableViewController *vc = [[WDTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
