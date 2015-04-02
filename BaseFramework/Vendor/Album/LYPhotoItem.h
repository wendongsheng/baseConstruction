//
//  PhotoItem.h
//  LYImagePickView_Demo
//
//  Created by wendongsheng on 14-5-30.
//  Copyright (c) 2014年 wendongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#pragma mark - 照片模型
@interface LYPhotoItem : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL isSelected;

- (id)initWithAsset:(ALAsset *)asset;

@end

