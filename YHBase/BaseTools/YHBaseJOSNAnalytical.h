//
//  YHBaseJOSNAnalytical.h
//  
//
//  Created by user on 15/8/19.
//
//解析json数据的工具类

#import <Foundation/Foundation.h>

@interface YHBaseJOSNAnalytical : NSObject
//解析为字典的方法
+(NSDictionary *)dictionaryWithJSData:(NSData *)data;
@end
