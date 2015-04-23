//
//  TestOneVC.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/15.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "TestOneVC.h"

@interface TestOneVC ()

@end

@implementation TestOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rdv_tabBarController.tabBarHidden = YES;
    
    self.title = @"这个屏幕支持旋转";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕旋转问题
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
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
