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
@end
