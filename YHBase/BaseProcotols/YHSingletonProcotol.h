//
//  YHSingletonProcotol.h
//  
//
//  Created by user on 15/8/17.
//
//单例的协议 遵守这个协议的类使用特定的方法创建单例，方便维护

#import <Foundation/Foundation.h>

@protocol YHSingletonProcotol <NSObject>
+(instancetype)sharedTheSingletion;
@end
