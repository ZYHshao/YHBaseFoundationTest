//
//  YHBaseError.h
//  
//
//  Created by user on 15/8/19.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    YHBaseErrorRequestFromHost=1,
    YHBaseErrorRequestLocal
}YHBaseErrorType;
@interface YHBaseError : NSError

@property(nonatomic,assign)YHBaseErrorType errorType;
//初始化方法
-(instancetype)initWithType:(YHBaseErrorType)type;
@end
