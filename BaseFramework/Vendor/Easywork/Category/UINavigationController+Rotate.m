//
//  UINavigationController+Rotate.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/2.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "UINavigationController+Rotate.h"

@implementation UINavigationController (Rotate)
/**
 *  ios 5.X
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

/**
 *  ios 6 and later
 */
- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end
