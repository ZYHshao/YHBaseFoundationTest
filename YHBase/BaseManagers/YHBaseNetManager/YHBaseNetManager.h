//
//  YHBaseNetManager.h
//  YHBaseFoundationTest
//
//  Created by vip on 16/5/18.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
/*
 这个类是基于YHBaseHttpManager类的上层封装 使用plist和配置model的方式来请求数据
 plist文件的结构必须标准：
 例如
 name：请求名 （通过请求名来取相应的请求模型）
 method：GET 或者 POST 可进行put与delete的扩展
 url：www.baidu.com
 param：paramModel
 data：dataModel
 注意：这里的协议可以进行扩展 例如是否缓存字段，缓存路径字段等
 ***************
 
 */

#import <Foundation/Foundation.h>
#import "YHBaseNetModel.h"
@interface YHBaseNetManager : YHBaseManager
/**
 *  @brief 这个方法通过名称进行相应的请求
 *
 *  @name plist文件中配置的请求名称
 *
 *  @param 请求参数配置模型
 *
 *  @data 请求返回数据模型对象
 *
 *  @completion 请求完成后的回调 成功或失败 如果成功 data对象会被自动赋值 失败则会有错误信息
 *
 */
-(void)netForRequestName:(NSString *)name withParam:(YHBaseModel *)param forDataModel:(YHBaseModel *)data completion:(void(^)(BOOL success,YHBaseError *error))completion;
@end
