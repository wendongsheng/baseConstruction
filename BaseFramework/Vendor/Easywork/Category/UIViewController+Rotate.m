//
//  UIViewController+Rotate.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/15.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "UIViewController+Rotate.h"

@implementation UIViewController (Rotate)
//ios5.X
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

//ios6.X and later
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
