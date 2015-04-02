//
//  UITabBarController+Rotate.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/2.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "UITabBarController+Rotate.h"

@implementation UITabBarController (Rotate)

//ios5.X
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

/**
 *  ios6.X and later
 */
- (BOOL)shouldAutorotate{
    return NO;
}

@end
