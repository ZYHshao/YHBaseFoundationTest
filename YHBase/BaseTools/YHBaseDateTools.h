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
 *  @author jaki, 15-09-21 17:09:18
 *
 *  @brief  获取当前系统时间
 *
 *  @return 格式化的当前时间字符串yyyy-MM-dd HH:mm:ss
 */
+(NSString *)getCurrentTime;
/**
 *  @author jaki, 15-09-21 17:09:09
 *
 *  @brief  获取当前月的下个月一号的date
 *
 *  @param date 当前月的任意一天
 *
 *  @return 下个月一号
 */
+(NSDate *)getNextMonthframDate:(NSDate*)date;
/**
 *  @author jaki, 15-09-21 17:09:52
 *
 *  @brief  获取当前月上个月一号的date
 *
 *  @param date 当前月的任意一天
 *
 *  @return 上个月的一号
 */
+(NSDate *)getPreviousframDate:(NSDate *)date;
/**
 *  @author jaki, 15-09-21 17:09:42
 *
 *  @brief  获取一个标准时间戳与当前时间的时间差
 *          这个类似交友社区的动态时间 几天前 几个小时前 几分钟前 刚刚这样
 *
 *  @param tinterval 时间戳
 *
 *  @return 距离当前时间的时间间隔
 */
+(NSString *)getStandardTimeInterval:(NSTimeInterval)tinterval;


@end
