//
//  NSDate+YHBaseCalendar.h
//  
//
//  Created by user on 15/9/6.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (YHBaseCalendar)
/**
 *获取当前月的天数
 */
- (NSUInteger)YHBaseNumberOfDaysInCurrentMonth;
/**
 *获取本月第一天
 */
- (NSDate *)YHBaseFirstDayOfCurrentMonth;




//下面这些方法用于获取各种整形的数据
/**
 *确定某天是周几
 */
-(int)YHBaseWeekly;
/**
 *年月日 时分秒
 */
-(int)getYear;
-(int)getMonth;
-(int)getDay;
-(int)getHour;
-(int)getMinute;
-(int)getSecond;

@end
