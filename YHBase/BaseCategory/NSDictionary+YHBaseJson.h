//
//  NSDictionary+YHBaseJson.h
//  
//
//  Created by user on 15/9/2.
//
//转字典转为json串

#import <Foundation/Foundation.h>
typedef enum {
    YHBaseJosnStyleNone=0,//无风格
    YHBaseJosnStyleNoneWarp=1<<1,//无换行
    YHBaseJosnStyleSinglequotationMark=1<<2,//单引号风格
    YHBaseJosnStyleDoubleQuotationMark=1<<3,//双引号风格
    YHBaseJosnStyleNoneSpace=1<<4,//无空格
    YHBaseJosnStyleNoneKeyMark=1<<5//去掉键值引号
    
}YHBaseJosnStyle;
@interface NSDictionary (YHBaseJson)
//将字典转为json
-(NSString*)transToJsonStringWithStyle:(YHBaseJosnStyle)style;
@end
