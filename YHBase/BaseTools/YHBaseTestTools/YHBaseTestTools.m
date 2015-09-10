//
//  YHBaseTestTools.m
//  
//
//  Created by user on 15/9/10.
//
//

#import "YHBaseTestTools.h"
void YHBaseTestLog(NSString *str,...){
    va_list list;
    va_start(list, str);
    if (![YHBaseTestLock sharedTheSingletion]->_customLock) {
           NSLogv(str, list);
    }
    va_end(list);
}
void YHBaseProcessLog(NSString *str,...){
    va_list list;
    va_start(list, str);
    if (![YHBaseTestLock sharedTheSingletion]->_precessLock) {
        NSLogv(str, list);
    }
    va_end(list);
}
@implementation YHBaseTestTools

@end
