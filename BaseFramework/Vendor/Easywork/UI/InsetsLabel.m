//
//  InsetsLabel.m
//  etthdclass
//
//  Created by Developer.Lx on 15/5/15.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "InsetsLabel.h"

@implementation InsetsLabel

- (void)drawTextInRect:(CGRect)rect
{
    rect = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(self.topEdgeInset, self.leftEdgeInset, self.bottomEdgeInset, self.rightEdgeInset));
    rect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:rect];
}

@end
