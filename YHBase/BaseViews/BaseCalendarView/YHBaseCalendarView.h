//
//  YHBaseCalendarView.h
//  
//
//  Created by user on 15/9/6.
//
//日历控件视图 这个目前自定义功能不强  有时间了再扩展

#import "YHBaseView.h"

@protocol YHBaseCalendarViewDelegate<NSObject>
-(void)YHBaseCalendarViewSelectAtDateModel:(YHBaseDateModel *)dateModel;
-(void)YHBaseCalendarViewScrollEndToDate:(YHBaseDateModel *)dateModel;
@end


@interface YHBaseCalendarView : YHBaseView
@property(nonatomic,strong)NSDate * currentDate;
//标记数组 用于标记特殊日期 这个数组中存放的必须是YHBaseDateModel 对象
@property(nonatomic,strong)NSArray * markArray;

@property(nonatomic,weak)id<YHBaseCalendarViewDelegate> delegate;
@end
