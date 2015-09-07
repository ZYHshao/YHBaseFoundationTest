//
//  YHBaseError.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseError.h"

@implementation YHBaseError
-(instancetype)initWithType:(YHBaseErrorType)type{
    self = [self init];
    if (self) {
        _errorType = type;
    }
    return self;
}
@end
