//
//  YHBaseTimerNode.h
//  
//
//  Created by user on 15/8/31.
//
//这个一个动作节点类 

#import <Foundation/Foundation.h>

@interface YHBaseTimerNode : NSObject
/**
 *回调block
 */
@property(nonatomic,copy)void(^callback)();
/**
 *执行频率
 */
@property(nonatomic,assign)int timer;
/**
 *id
 */
@property(nonatomic,strong)NSString * name;
/**
 *有效性
 */
@property(nonatomic,assign)BOOL isValid;
/**
 *是否应该移除
 */
@property(nonatomic,assign)BOOL shouldRemove;
@end
