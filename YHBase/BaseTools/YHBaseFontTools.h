//
//  YHBaseFontTools.h
//  YHBaseFoundationTest
//
//  Created by jaki on 15/10/9.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//
/**
 *  @author jaki, 15-10-09 19:10:29
 *
 *  @brief  一些字体的工具方法
 */
#import <Foundation/Foundation.h>

@interface YHBaseFontTools : NSObject
/*=============
 下面这个方法从字体库plist文件中获取所有系统字体后，与默认的进行比较，只会将新添加的字体名称打印出来
 这么做，方面了开发人员查找这个字体的名字
 字体库的版本为Xcode6.3
 ============*/
/**
 *  @author jaki, 15-10-09 19:10:03
 *
 *  @brief  打印添加进工程的新字体的字体名字
 *
 */
+(void)logNewFont;
@end
