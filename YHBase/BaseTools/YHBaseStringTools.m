//
//  YHBaseStringTools.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseStringTools.h"

@implementation YHBaseStringTools


BOOL YHBaseCheckString(YHBaseStringCompareType compareType,NSString * str,int length){
    switch (compareType) {
        case YHBaseStringCompareEqual:
        {
            if (str.length!=length) {
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case YHBaseStringCompareLonger:
        {
            if (str.length>length) {
                return YES;
            }else{
                return NO;
            }
        }
            break; case YHBaseStringCompareShorter:
        {
            if (str.length<length) {
                return YES;
            }else{
                return NO;
            }
        }
            break;
        default:
            break;
    }
}

NSString * YHBaseSequenceString(YHBaseStringCompareType sequenceType, NSString * str){
    NSMutableString * muStr = [[NSMutableString alloc]init];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i=0; i<str.length;i++ ) {
        [array addObject:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]];
    }
    switch (sequenceType) {
        
        case YHBaseStringCompareEqual:
            return str;
            break;
        case YHBaseStringCompareLonger://从小到大
        {
            for (int i=0; i<array.count; i++) {
                for (int j=i+1; j<array.count; j++) {
                    if ([array[i] characterAtIndex:0]>[array[j] characterAtIndex:0]) {
                        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                }
            }
            for (int i=0; i<array.count; i++) {
                [muStr appendString:array[i]];
            }
            return muStr;
        }
            break;
        case YHBaseStringCompareShorter://从大到小
        {
            for (int i=0; i<array.count; i++) {
                for (int j=i+1; j<array.count; j++) {
                    if ([array[i] charValue]<[array[j] charValue]) {
                        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                }
            }
            for (int i=0; i<array.count; i++) {
                [muStr appendString:array[i]];
            }
            return muStr;
        }
            break;
        default:
            return str;
            break;
    }
}

NSString * YHBaseInsertCharater(NSString * chara ,NSString * str){
    NSMutableString * newStr = [[NSMutableString alloc]init];
    for (int i=0; i<str.length; i++) {
        if (i<str.length-1) {
            [newStr appendString:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]];
            [newStr appendString:chara];
        }
    }
    return newStr;
}





@end
