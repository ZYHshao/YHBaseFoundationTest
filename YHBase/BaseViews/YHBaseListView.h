//
//  YHBaseListView.h
//  
//
//  Created by user on 15/8/31.
//
//菜单视图

#import "YHBaseView.h"

@class YHBaseListView;
@protocol YHBaseListViewDelegate <NSObject>
/**
 *点击item回调的代理 index从0开始
 */
-(void)YHBaseListViewClickAtIndex:(int)index;

@end



@interface YHBaseListView : YHBaseView
/**
 *item数组
 */
@property(nonatomic,strong)NSArray * itemsArray;

@property(nonatomic,weak)id<YHBaseListViewDelegate> delegate;

/**
 *设置行高
 */
@property(nonatomic,assign)CGFloat itemHight;

@property(nonatomic,assign,readonly)BOOL isShow;

/**
 *弹出菜单
 */
-(void)openList;
/**
 *收回菜单
 */
-(void)closeList;

@end
