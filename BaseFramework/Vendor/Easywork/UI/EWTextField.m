//
//  EWTextField.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/3.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "EWTextField.h"

@interface EWTextField ()

@property (nonatomic, strong) UIColor *placeHolderColor;

@end

@implementation EWTextField

- (instancetype)initWithFrame:(CGRect)frame placeHolderColor:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        _placeHolderColor = color;
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    [_placeHolderColor setFill];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
#else
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
#endif
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width-10, bounds.size.height);
    return inset;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
