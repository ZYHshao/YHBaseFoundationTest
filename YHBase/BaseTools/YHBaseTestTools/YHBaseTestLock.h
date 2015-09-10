//
//  YHBaseTestLock.h
//  
//
//  Created by user on 15/9/10.
//
//

#import <Foundation/Foundation.h>

@interface YHBaseTestLock : NSObject<YHSingletonProcotol>
{
    @public
    BOOL _customLock;
    BOOL _precessLock;
}
+(void)customLock;
+(void)customUnLock;

+(void)processLogLock;
+(void)processLogUnLock;


@end
