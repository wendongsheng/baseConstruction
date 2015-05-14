//
//  HistoryModel.h
//  BaseFramework
//
//  Created by wendongsheng on 15/5/13.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryModel : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;

@end
