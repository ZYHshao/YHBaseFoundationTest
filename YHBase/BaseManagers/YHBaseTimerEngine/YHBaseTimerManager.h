//
//  YHBaseTimerManager.h
//  
//
//  Created by user on 15/8/31.
//
//统一管理定时器动作 

#import "YHBaseManager.h"

@interface YHBaseTimerManager : YHBaseManager
/**
 *在管理中心中注册一个动作
 *@param action 动作的block
 *@param timer 执行频率 最大60/s 必须为60的约数
 *@param name 动作id
 */
-(void)registerAction:(void(^)())action
                timer:(int)timer
              andName:(NSString *)name;
/**
 *根据id设置动作的有效性
 */
-(void)setValid:(BOOL)isvalid toName:(NSString *)name;

/**
 *更新一个动作的执行频率
 */
-(void)upDataGameEngineTimer:(int)timer ForName:(NSString*)name;

/**
 *移除一个动作
 */
-(void)removeActionForName:(NSString *)name;

-(void)stopAllAction;//暂停所有动作
-(void)beginAllAction;//开启所有动作

@end
