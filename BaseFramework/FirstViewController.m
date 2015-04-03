//
//  FirstViewController.m
//  BaseFramework
//
//  Created by wendongsheng on 15/3/31.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//
#define kUrl @"http://attach.etiantian.com/common/parentCircle/activity/15795_59099190.jpg"
#import "FirstViewController.h"
#import "EWFocusView.h"

@interface FirstViewController ()<EWFocusViewDataSource, EWFocusViewDelegate>

@property (nonatomic, strong) EWFocusView *focusView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _focusView = [[EWFocusView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200) showPageIndicator:YES];
    _focusView.dataSource = self;
    _focusView.timeInterval = 2.0;
    _focusView.delegate = self;
    [_focusView reloadData];
    [_focusView startAutoRun];

    [self.view addSubview:self.focusView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfPages:(EWFocusView *)focusView{
    return 10;
}

- (UIView *)focusView:(EWFocusView *)focusView pageAtIndex:(NSInteger)index{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
    image.userInteractionEnabled = YES;
    [image sd_setImageWithURL:[NSURL URLWithString:kUrl] placeholderImage:[UIImage imageNamed:@"user_photo"]];
    return image;
}

- (void)focusView:(EWFocusView *)focusView didSelectAtIndex:(NSInteger)index{
    NSLog(@"ddddddddddddd");
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
