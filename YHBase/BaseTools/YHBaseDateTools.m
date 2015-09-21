//
//  YHBaseDateTools.m
//  StudyApp
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseDateTools.h"

@implementation YHBaseDateTools
+(NSString *)getCurrentTime{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * time = [formatter stringFromDate:[NSDate date]];
    return time;
}
+(NSDate *)getNextMonthframDate:(NSDate*)date{
    NSCalendar *  _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit _dayInfoUnits  = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:date];
    components.day = 1;
    components.month ++;
    NSDate * nextMonthDate =[_gregorian dateFromComponents:components];
    return nextMonthDate;
}
+(NSDate *)getPreviousframDate:(NSDate *)date{
    NSCalendar *  _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit _dayInfoUnits  = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:date];
    components.day = 1;
    components.month --;
    NSDate * previousMonthDate =[_gregorian dateFromComponents:components];
    return previousMonthDate;
}
+(NSString *)getStandardTimeInterval:(NSTimeInterval)tinterval{
    //进行时间差比较
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeInterval = time-tinterval;
    int day = timeInterval/(60*60*24);
    int hour = ((long)timeInterval%(60*60*24))/(60*60);
    int minite = ((long)timeInterval%(60*60*24))%(60*60)/60;
    NSMutableString * timeStr = [[NSMutableString alloc]init];
    if (day!=0) {
        [timeStr appendString:[NSString stringWithFormat:@"%d天前",day]];
    }else{
        if (hour!=0) {
            [timeStr appendString:[NSString stringWithFormat:@"%d小时前",hour]];
        }else{
            if (minite<1) {
                [timeStr appendString:@"刚刚"];
            }else{
                [timeStr appendString:[NSString stringWithFormat:@"%d分钟前",minite]];
            }
        }
    }
    return timeStr;
}
@end
