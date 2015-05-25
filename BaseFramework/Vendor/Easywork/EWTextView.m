//
//  EWTextView.m
//  Easywork+(UITextView_placeholder)
//
//  Created by Kingxl on 5/24/15.
//  Copyright (c) 2015 Kingxl. All rights reserved.
//

#import "EWTextView.h"

@interface EWTextView ()
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation EWTextView

#pragma mark - Init method
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"font"];
    [self removeObserver:self forKeyPath:@"textAlignment"];
    [self removeObserver:self forKeyPath:@"textContainerInset"];
}

#pragma mark - Config
- (void)initialize
{
    //add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_adjustPlaceholderLabel) name:UITextViewTextDidChangeNotification object:nil];
    
    //add kvo
    [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"textAlignment" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"textContainerInset" options:NSKeyValueObservingOptionNew context:NULL];
    
    //add placeholderLabel
    [self insertSubview:self.placeholderLabel atIndex:0];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self p_adjustPlaceholderLabel];
    
}

- (void)p_adjustPlaceholderLabel
{
    if (self.text.length) {
        _placeholderLabel.frame = CGRectZero;
        return;
    }else{
        _placeholderLabel.font = self.font;
        _placeholderLabel.textAlignment = self.textAlignment;
        
        CGFloat x = self.textContainer.lineFragmentPadding + self.textContainerInset.left;
        CGFloat y = self.textContainerInset.top;
        CGFloat width = CGRectGetWidth(self.bounds) - x - self.textContainer.lineFragmentPadding  - self.textContainerInset.right;
        CGFloat height = [_placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        _placeholderLabel.frame = CGRectMake(x, y, width, height);
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self p_adjustPlaceholderLabel];
}


#pragma mark - Setter & Getter
- (NSString *)placeholder
{
    return _placeholderLabel.text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    
    [self p_adjustPlaceholderLabel];
}

- (UIColor *)placeholderColor
{
    return  _placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderLabel.textColor = placeholderColor;
    
    [self p_adjustPlaceholderLabel];
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0.098 alpha:0.22]; //like UItextField placeholder color
        _placeholderLabel.userInteractionEnabled = NO;
        self.text = @" "; //Gets the default font size, if you do not set the font size
        _placeholderLabel.font = self.font;
        self.text = @"";
    }
    return _placeholderLabel;
}

@end
