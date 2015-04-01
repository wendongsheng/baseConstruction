//
//  NSJSONSerialization+Extension.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "NSJSONSerialization+Extension.h"

@implementation NSJSONSerialization (Extension)

+ (NSString *)ew_jsonStringFromArray:(NSArray *)array{
    NSAssert(nil != array, @"nil array");
    NSAssert([array isKindOfClass:[NSArray class]], @"array is not an NSArray instance");
    NSAssert(0 != [array count], @"empty array");
    
    return [self formatData:array];
}

+ (NSString *)ew_jsonStringFromDictionary:(NSDictionary *)dictionary{
    NSAssert(nil != dictionary, @"nil dictionary");
    NSAssert([dictionary isKindOfClass:[NSDictionary class]], @"dictionary is not an NSDictionary instance");
    NSAssert(0 != [[dictionary allKeys] count], @"empty dictionary");
    
    return [self formatData:dictionary];
}

+ (NSString *)ew_jsonStringFromObject:(id)object{
    if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
        return [self formatData:object];
    }
    return nil;
}

+ (NSString *)formatData:(id)data{
    NSError *error;
    NSData * jsonData = [self dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"Json format error %@",error.localizedDescription);
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
