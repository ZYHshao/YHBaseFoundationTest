//
//  YHBaseErrorCenter.h
//  
//
//  Created by user on 15/8/19.
//
//异常中心的基类,遵守单例协议 根据项目进行继承，采用通知的模式，发生错误进行通知处理

#import <Foundation/Foundation.h>
#import "YHBaseManager.h"
@interface YHBaseErrorCenter :YHBaseManager
//子类实现这个方法进行错误处理
-(void)handleToError:(YHBaseError *)error;
@end
