//
//  YHBaseJOSNAnalytical.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseJOSNAnalytical.h"

@implementation YHBaseJOSNAnalytical
+(NSDictionary *)dictionaryWithJSData:(NSData *)data{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}
@end
