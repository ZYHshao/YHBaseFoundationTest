//
//  YHBaseTestTools.h
//  
//
//  Created by user on 15/9/10.
//
//这个类重写了NSLog方法，对外界是透明的，原来的调用方式不变，
//但是可以通过YHBaseTestLock锁来个人打印个人的调试信息
//这个方法 在多人和做中十分重要

#import <Foundation/Foundation.h>
#import "YHBaseTestLock.h"
#define NSLog(...) YHBaseTestLog(__VA_ARGS__)
void YHBaseTestLog(NSString *str,...);
void YHBaseProcessLog(NSString *str,...);
@interface YHBaseTestTools : NSObject

@end
