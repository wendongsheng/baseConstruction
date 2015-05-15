//
//  ThirdViewController.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/14.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "ThirdViewController.h"
#import "TestOneVC.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.backgroundColor = WHITE_COLOR;
//    button.frame = CGRectMake(10, 200, SCREEN_WIDTH-2*10, 30);
//    [button setTitle:@"" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(handleButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
}


- (void)handleButton{
    TestOneVC *VC = [[TestOneVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
