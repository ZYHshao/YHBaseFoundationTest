//
//  YHBaseHttpManager.h
//  
//
//  Created by user on 15/8/18.
//
//http网络请求的管理基类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YHBaseHttpRequestObject.h"
#import "YHBaseCecheCenter.h"
@interface YHBaseHttpManager : YHBaseManager
/**
 *请求数据，用于存储正在进行的请求
 */
__PROPERTY_NO_STRONG__(NSMutableArray *, requestArray);

/**
 *发起get请求，可以进行缓存,支持设置缓存的类型路径
 *
 */
-(void)YHBaseHttpRequestGETFromRequestObject:(YHBaseHttpRequestObject *)obj
                              requestSuccess:(void(^)(NSData* data))successBlock
                                requestField:(void(^)(YHBaseError * error))fieldBlock
                                     isCeche:(BOOL)ceche
                                 toCechePath:(YHBaseCechePath)path;
/**
 *发起post请求，可以进行缓存
 */
-(void)YHBaseHttpRequestPOSTFromRequestObject:(YHBaseHttpRequestObject *)obj
                          withParamDictionary:(NSDictionary *)paramDic
                               requestSuccess:(void(^)(NSData* data))successBlock
                                 requestField:(void(^)(YHBaseError * error))fieldBlock
                                      isCeche:(BOOL)ceche
                                  toCechePath:(YHBaseCechePath)path;


@end
