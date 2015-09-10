//
//  YHBaseTestLock.m
//  
//
//  Created by user on 15/9/10.
//
//

#import "YHBaseTestLock.h"

@implementation YHBaseTestLock

+(instancetype)sharedTheSingletion{
    static YHBaseTestLock * sharedModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedModel = [[YHBaseTestLock alloc] init];
    });
    return sharedModel;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _customLock=NO;
        _precessLock=YES;
    }
    return self;
}

+(void)customLock{
    [YHBaseTestLock sharedTheSingletion]->_customLock=YES;
}
+(void)customUnLock{
      [YHBaseTestLock sharedTheSingletion]->_customLock=NO;
}

+(void)processLogLock{
     [YHBaseTestLock sharedTheSingletion]->_precessLock=YES;
}
+(void)processLogUnLock{
    [YHBaseTestLock sharedTheSingletion]->_precessLock=NO;
}
@end
