//
//  UIFont+Extension.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
- (CGFloat)ew_lineHeight{
    return (self.ascender-self.descender) + 1;
}
@end
