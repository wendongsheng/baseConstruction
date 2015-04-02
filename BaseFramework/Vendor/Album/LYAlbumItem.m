//
//  AlbumItem.m
//  LYImagePickView_Demo
//
//  Created by wendongsheng on 14-5-29.
//  Copyright (c) 2014年 wendongsheng. All rights reserved.
//

#import "LYAlbumItem.h"

@implementation LYAlbumItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.photos = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

@end
