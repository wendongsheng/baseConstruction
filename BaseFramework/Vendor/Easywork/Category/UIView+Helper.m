//
//  UIView+Helper.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
- (UIViewController *)viewController{
    for (UIView *next=[self superview]; next; next=next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
