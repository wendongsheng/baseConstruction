//
//  NSJSONSerialization+Extension.h
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Extension)

/** Json format an array */
+ (NSString *)ew_jsonStringFromArray:(NSArray *)array;

/** Json format a dictionary */
+ (NSString *)ew_jsonStringFromDictionary:(NSDictionary *)dictionary;

/** Json format an object (NSArray or Dictionary)*/
+ (NSString *)ew_jsonStringFromObject:(id)object;

@end
