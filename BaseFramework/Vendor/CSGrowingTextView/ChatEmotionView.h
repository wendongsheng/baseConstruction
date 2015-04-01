//
//  ChatEmotionView.h
//  四中网校-ios
//
//  Created by 老岳 on 14-7-4.
//  Copyright (c) 2014年 老岳. All rights reserved.
//

#define EmotionView_H 200.0f
#define Emotion_W SCREEN_WIDTH/7 //每个表情的大小
#define Emotion_H 38.0f

#import <UIKit/UIKit.h>

@protocol ChatEmotionViewDelegate;
@interface ChatEmotionView : UIView

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIButton *deleteButton; //删除按钮
@property (nonatomic, strong) UIButton *sendButton;   //发送按钮
@property (nonatomic, weak) id <ChatEmotionViewDelegate> delegate;

@end


@protocol ChatEmotionViewDelegate <NSObject>

- (void)chatEmotionView:(ChatEmotionView *)emotionView didSelectEmotionImgName:(NSString *)emotionName;

@end
