//
//  WDTableViewCell.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/14.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "WDTableViewCell.h"

@interface WDTableViewCell ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation WDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor orangeColor];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-2*10, self.frame.size.height-2*10)];
        self.textField.placeholder = @"这是文本框";
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
