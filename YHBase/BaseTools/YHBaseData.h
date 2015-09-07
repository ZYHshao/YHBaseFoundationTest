//
//  YHBaseData.h
//  StudyApp
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBaseData : NSData
/**
 *直接通过url字符串下载data数据 兼容中文字符
 */
+(NSData *)getDataWithUrl:(NSString*)urlStr;
@end
