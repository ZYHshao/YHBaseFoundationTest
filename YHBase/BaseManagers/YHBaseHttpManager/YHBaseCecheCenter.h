//
//  YHBaseCecheCenter.h
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//缓存的基类

#import <Foundation/Foundation.h>
#import "YHBaseCecheHeader.h"

@interface YHBaseCecheCenter : YHBaseManager

//缓存地址，根据需求选用
/*
 *主缓存地址
 */
__PROPERTY_NO_STRONG__READLY__(NSString *, mainCechePath);
/**
 *图片缓存地址
 */
__PROPERTY_NO_STRONG__READLY__(NSString *, imageCechePath);
/**
 *文件缓存地址
 */
__PROPERTY_NO_STRONG__READLY__(NSString *, fileCechePath);
/**
 *视频缓存地址
 */
__PROPERTY_NO_STRONG__READLY__(NSString *, videoCechePath);
/**
 *音频缓存地址
 */
__PROPERTY_NO_STRONG__READLY__(NSString *, audioCechePath);


/**
 *  @author jaki, 15-09-29 18:09:02
 *
 *  @brief  读取缓存文件
 *
 *  @param fileID 文件的id
 *  @param path   文件存储的路径
 *
 *  @return 缓存的data数据
 */
-(NSData *)readCecheFile:(NSString *)fileID fromPath:(YHBaseCechePath)path;
/**
 *  @author jaki, 15-09-29 18:09:43
 *
 *  @brief  存入缓存文件
 *
 *  @param data   要缓存的数据
 *  @param fileID 数据id
 *  @param path   存入的目录
 */
-(void)writeCecheFile:(NSData *)data withFileID:(NSString *)fileID toPath:(YHBaseCechePath)path;
/**
 *  @author jaki, 15-09-29 18:09:37
 *
 *  @brief  获取缓存的数据大小
 *
 *  @param path 缓存目录
 *
 *  @return 数据大小 单位为M
 */
-(float)getSizeFromCachePath:(YHBaseCechePath)path;
/**
 *  @author jaki, 15-09-29 18:09:23
 *
 *  @brief  获取所有的缓存大小
 *
 *  @return 缓存大小 单位为M
 */
-(float)getAllCache;
/**
 *  @author jaki, 15-09-29 18:09:51
 *
 *  @brief  删除指定目录下的缓存
 *
 *  @param path 缓存目录
 */
-(void)removeCacheFromPath:(YHBaseCechePath)path;
/**
 *  @author jaki, 15-09-29 18:09:23
 *
 *  @brief  清除所有缓存
 */
-(void)removeAllCache;

/**********************************
 上面的方法用于网络请求数据的存储，下面的方法直接对对象进行存储，并且外界不需实现归档方法，直接存，直接去
 **********************************/




@end
