//
//  YHBaseErrorCenter.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseErrorCenter.h"

@implementation YHBaseErrorCenter
+(instancetype)sharedTheSingletion{
    static YHBaseErrorCenter * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //添加监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleError:) name:YHBASE_ERROR_CENTER_NOTICATION object:nil];
    }
    return self;
}
-(void)handleError:(NSNotification*)obj{
    NSDictionary * userInfo = obj.userInfo;
    YHBaseError * error = [userInfo objectForKey:@"error"];
    [self handleToError:error];
}
//子类通过重写这个方法来统一处理错误
-(void)handleToError:(YHBaseError *)error{
//    NSLog(@"异常");
}

@end
