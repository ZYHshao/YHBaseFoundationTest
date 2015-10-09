//
//  YHBaseFontTools.m
//  YHBaseFoundationTest
//
//  Created by jaki on 15/10/9.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseFontTools.h"

@implementation YHBaseFontTools
+(void)logNewFont{
    NSString *paths=[[NSBundle mainBundle]pathForResource:@"font" ofType:@"plist"];
    
    //得到完整的文件名
    NSDictionary * rootDic = [NSDictionary dictionaryWithContentsOfFile:paths];
    //遍历当前所有字体
    for (NSString * name in [UIFont familyNames]) {
        NSArray * fontArray = [rootDic objectForKey:name];
        BOOL tip = NO;
        for (NSString * fo in [UIFont fontNamesForFamilyName:name]) {
            for (NSString * tmp in fontArray) {
                if ([tmp isEqualToString:fo]) {
                    tip=YES;
                    break;
                }
            }
            if (!tip) {
                NSLog(@"%@",fo);
            }
        }
    }

}
@end
