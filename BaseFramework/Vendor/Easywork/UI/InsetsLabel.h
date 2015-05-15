//
//  InsetsLabel.h
//  etthdclass
//
//  Created by Developer.Lx on 15/5/15.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel

@property (nonatomic,assign) CGFloat topEdgeInset NS_AVAILABLE_IOS(2_0);
@property (nonatomic,assign) CGFloat bottomEdgeInset NS_AVAILABLE_IOS(2_0);
@property (nonatomic,assign) CGFloat leftEdgeInset NS_AVAILABLE_IOS(2_0);
@property (nonatomic,assign) CGFloat rightEdgeInset NS_AVAILABLE_IOS(2_0);

@end
