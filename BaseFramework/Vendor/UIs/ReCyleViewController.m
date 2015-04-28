//
//  ReCyleViewController.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/14.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "ReCyleViewController.h"
#import "EWFocusView.h"

@interface ReCyleViewController ()<EWFocusViewDataSource, EWFocusViewDelegate>

@property (nonatomic, strong) UIView *cycleView;
@property (nonatomic, strong) EWFocusView *focusView;

@end

@implementation ReCyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self randomColor];
    self.cycleView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
    _cycleView.backgroundColor = YELLOW_COLOR;
    [self.view addSubview:_cycleView];
    
    [self createCycleView];
    
    [self startCycleView];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [_focusView stopAutoRun];
}

- (void)startCycleView{
    [_focusView reloadData];
    [_focusView startAutoRun];
}

- (void)createCycleView{
    // focus view
    _focusView = [[EWFocusView alloc] initWithFrame:_cycleView.bounds showPageIndicator:YES];
    _focusView.delegate = self;
    _focusView.dataSource = self;
    _focusView.timeInterval = 3;
    [_cycleView addSubview:_focusView];

}

#pragma mark - focus view delegate
- (UIView *)focusView:(EWFocusView *)focusView pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_focusView.bounds];
//    if (self.picData.count > 0 && self.picData.count>index) {
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[_picData[index] pic]]];
//    }
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = ImageNamed(@"cycleImage");
    imageView.backgroundColor = [self randomColor];
    return imageView;
}

- (NSString *)focusView:(EWFocusView *)focusView titleForPageAtIndex:(NSInteger)index
{
    return @"";
}

- (NSInteger)numberOfPages:(EWFocusView *)focusView
{
    return 5;
}


- (void)focusView:(EWFocusView *)focusView didSelectAtIndex:(NSInteger)index
{
    CLog(@"点击了第%ld",index);
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
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
