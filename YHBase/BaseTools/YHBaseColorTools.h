//
//  YHBaseColorTools.h
//  YHBaseFoundationTest
//
//  Created by jaki on 15/12/23.
//  Copyright © 2015年 jaki.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBaseColorTools : NSObject
/**
 *将16进制颜色字符串转化为UIColor对象
 */
+(UIColor *)YHBaseColorFromHexString:(NSString *)HexString;
/**
 *将UIColor对象转为16进制字符串 以#开头
 */
+(NSString *)YHBaseHexStringFromColor:(UIColor *)color;
/**
 *将十进制数转换为16进制 字符串
 */
+(NSString *)ToHex:(int)tmpid;
@end
