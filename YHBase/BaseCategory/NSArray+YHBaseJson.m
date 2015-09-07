//
//  NSArray+YHBaseJson.m
//  
//
//  Created by user on 15/9/2.
//
//

#import "NSArray+YHBaseJson.h"
#import "YHBaseModel.h"
#import "NSDictionary+YHBaseJson.h"
@implementation NSArray (YHBaseJson)
-(NSString*)transToJsonString:(YHBaseJosnStyle)style{
    NSMutableString * jsStr = [[NSMutableString alloc]init];
    [jsStr appendString:@"["];
    for (int i =0 ; i<self.count; i++) {
        //数据对象
        if ([[self[i] class]isSubclassOfClass:[YHBaseModel class]]) {
            NSDictionary * dic = [self[i] modelMappingToDictionary];
            [jsStr appendString:[dic transToJsonStringWithStyle:style]];
        }else
        //字典
        if ([[self[i] class]isSubclassOfClass:[NSDictionary class]]) {
            [jsStr appendString:[self[i] transToJsonStringWithStyle:style]];
        }else
        //数组 使用递归
        if ([[self[i] class]isSubclassOfClass:[NSArray class]]) {
            [jsStr appendString:[self[i] transToJsonStringWithStyle:style]];
        }else
        //对象
        if ([[self[i] class]isSubclassOfClass:[NSObject class]]) {
            [jsStr appendString:[NSString stringWithFormat:@"%@",self[i]]];
        }
        if (i<self.count-1) {
            [jsStr appendString:@","];
        }else{
            [jsStr appendString:@"]"];
        }
    }
    return jsStr;
}
@end
