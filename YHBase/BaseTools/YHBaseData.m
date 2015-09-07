//
//  YHBaseData.m
//  StudyApp
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseData.h"

@implementation YHBaseData
+(NSData *)getDataWithUrl:(NSString *)urlStr{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    return data;
}
@end
