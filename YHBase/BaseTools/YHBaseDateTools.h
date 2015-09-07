//
//  YHBaseDateTools.h
//  StudyApp
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBaseDateTools : NSObject
/**
 *获取当前系统时间
 */
+(NSString *)getCurrentTime;
/**
 *获取当前月的下个月一号的date
 */
+(NSDate *)getNextMonthframDate:(NSDate*)date;
/**
 *获取当前月上个月一号的date
 */
+(NSDate *)getPreviousframDate:(NSDate *)date;
@end
