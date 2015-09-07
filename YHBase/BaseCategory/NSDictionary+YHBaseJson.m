//
//  NSDictionary+YHBaseJson.m
//  
//
//  Created by user on 15/9/2.
//
//

#import "NSDictionary+YHBaseJson.h"

@implementation NSDictionary (YHBaseJson)
-(NSString *)transToJsonStringWithStyle:(YHBaseJosnStyle)style{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString * tmp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
     //去换行符
    if (style&1<<1) {
        NSMutableString * newStr = [[NSMutableString alloc]init];
        NSArray * temArr = [tmp componentsSeparatedByString:@"\n"];
        for (int i=0; i<temArr.count; i++) {
            [newStr appendString:temArr[i]];
        }
        tmp = [newStr copy];
    }
    //单引号
    if (style&(1<<2)) {
        NSMutableString * newStr = [[NSMutableString alloc]init];
        NSArray * temArr = [tmp componentsSeparatedByString:@"\""];
        for (int i=0; i<temArr.count; i++) {
            [newStr appendString:temArr[i]];
            if (i!=temArr.count-1) {
                [newStr appendString:@"\'"];
            }
        }
        tmp = [newStr copy];
    }
    //双引号
    if (style&(1<<3)) {
        NSMutableString * newStr = [[NSMutableString alloc]init];
        NSArray * temArr = [tmp componentsSeparatedByString:@"\'"];
        for (int i=0; i<temArr.count; i++) {
            [newStr appendString:temArr[i]];
            if (i!=temArr.count-1) {
                [newStr appendString:@"\""];
            }
        }
        tmp = [newStr copy];
    }
    //无空格
    if (style&(1<<4)) {
        NSMutableString * newStr = [[NSMutableString alloc]init];
        NSArray * temArr = [tmp componentsSeparatedByString:@" "];
        for (int i=0; i<temArr.count; i++) {
            [newStr appendString:temArr[i]];
        }
        tmp = [newStr copy];
    }//键值无引号
    if (style&(1<<5)) {
        NSMutableString * newStr = [[NSMutableString alloc]initWithString:tmp];
        for (NSString * key in [self allKeys]) {
            if (style&1<<3) {
                NSRange range = [newStr rangeOfString:[NSString stringWithFormat:@"\"%@\"",key]];
                [newStr replaceCharactersInRange:range withString:key];
            }else if (style&1<<2){
                NSRange range = [newStr rangeOfString:[NSString stringWithFormat:@"\'%@\'",key]];
                [newStr replaceCharactersInRange:range withString:key];
            }
           
        }
        tmp = [newStr copy];
    }
    return tmp;
    
}
@end
