//
//  ChatEmotionView.m
//  四中网校-ios
//
//  Created by 老岳 on 14-7-4.
//  Copyright (c) 2014年 老岳. All rights reserved.
//

#import "ChatEmotionView.h"

@interface ChatEmotionView ()
{
    NSArray *emotionArray;
}

@end



@implementation ChatEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //背景
        self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, EmotionView_H)];
        self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, EmotionView_H);
        self.bgScrollView.backgroundColor = WHITE_COLOR;
        [self addSubview:self.bgScrollView];
        
        //表情按钮
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Emotion" ofType:@"plist"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        emotionArray = [dic valueForKey:@"emotion"];
        
        for (int i = 0; i<emotionArray.count; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@.png", [emotionArray objectAtIndex:i]];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.frame = CGRectMake((i%7)*Emotion_W, (i/7)*Emotion_H, Emotion_W, Emotion_H);
            [button setImage:ImageWithFile(name) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgScrollView addSubview:button];
        }
        
        //删除按钮
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = CGRectMake(6*Emotion_W, 3*Emotion_H, Emotion_W, Emotion_H);
        [self.deleteButton setImage:ImageWithFile(@"chatDetail_emotionDelete.png") forState:UIControlStateNormal];
        [self.deleteButton setImage:ImageWithFile(@"chatDetail_emotionDelete_h.png") forState:UIControlStateHighlighted];
        [self.bgScrollView addSubview:self.deleteButton];
        
        //发送按钮
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [ImageWithFile(@"setting_sendButton.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        [self.sendButton setBackgroundImage:image forState:UIControlStateNormal];
        [self.sendButton setTitle:@"发 送" forState:UIControlStateNormal];
        self.sendButton.backgroundColor = RGB_COLOR(85, 178, 239);
        [self.sendButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self.sendButton setTitleColor:RGB_COLOR(40, 80, 120) forState:UIControlStateHighlighted];
        float send_w = 80;
        float send_h = 40;
        self.sendButton.frame = CGRectMake(SCREEN_WIDTH-send_w, EmotionView_H-send_h, send_w, send_h);
        [self addSubview:self.sendButton];
    }
    return self;
}

#pragma mark - button events
- (void)emotionButtonClick:(UIButton *)button
{
    NSString *name = [emotionArray objectAtIndex:button.tag];
    
    [self.delegate chatEmotionView:self didSelectEmotionImgName:name];
}

@end


