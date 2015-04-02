//
//  UIButton+Extension.h
//  BaseFramework
//
//  Created by wendongsheng on 15/4/2.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  set background color for state
 *
 *  @param backgroundColor color
 *  @param state           state
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
