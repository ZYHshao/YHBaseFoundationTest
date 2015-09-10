//
//  YHBaseModelProtocol.h
//  
//
//  Created by user on 15/8/19.
//
//model类所遵守的协议，统一方法与框架

#import <Foundation/Foundation.h>

@protocol YHBaseModelProtocol <NSObject>
//model的创建方法
-(void)creatModelWithDic:(NSDictionary *)dic;
//提供一个字典的映射方法，将属性转化为字典
-(NSDictionary *)modelMappingToDictionary;
/**
 *这个方法将json数据直接映射成model 数据格式必须正规
 */
-(void)creatModelWithData:(NSData *)data;
@end
