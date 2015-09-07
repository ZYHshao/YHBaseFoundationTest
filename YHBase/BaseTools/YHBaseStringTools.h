//
//  YHBaseStringTools.h
//  
//
//  Created by user on 15/8/19.
//
//

#import <Foundation/Foundation.h>
/**
 *比较方法的枚举
 */
typedef enum {
    YHBaseStringCompareLonger=1,
    YHBaseStringCompareShorter,
    YHBaseStringCompareEqual
}YHBaseStringCompareType;
@interface YHBaseStringTools : NSObject
//====================================字符串检测函数=========================//
/**
 *检测字符串长度是否符合
 */
BOOL YHBaseCheckString(YHBaseStringCompareType compareType,NSString * str,int length);
/**
 *将字符串中进行进行排序 参数可以设置从大到小和从小到大 设置为equal则返回原字符串
 */
NSString * YHBaseSequenceString(YHBaseStringCompareType sequenceType, NSString * str);

/**
 *已规定的字符插入字符串中字符之间
 */
NSString * YHBaseInsertCharater(NSString * chara ,NSString * str);

@end
