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


/*
 *读取缓存文件
 */
-(NSData *)readCecheFile:(NSString *)fileID fromPath:(YHBaseCechePath)path;
/**
 *存入缓存文件
 */
-(void)writeCecheFile:(NSData *)data withFileID:(NSString *)fileID toPath:(YHBaseCechePath)path;
/**
 *获取目录下缓存内容大小,单位为M
 */
-(float)getSizeFromCachePath:(YHBaseCechePath)path;
/**
 *获取所有缓存大小，单位为M
 */
-(float)getAllCache;
/**
 *删除目录下的缓存文件
 */
-(void)removeCacheFromPath:(YHBaseCechePath)path;
/**
 *清除所有缓存
 */
-(void)removeAllCache;

@end
