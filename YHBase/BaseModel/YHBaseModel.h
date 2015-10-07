//
//  YHBaseModel.h
//  
//
//  Created by user on 15/8/19.
//
/**
 *这个基类实现了存储的功能，可以直接通过YHBaseCecheCenter
 *-(void)setValueModel:(YHBaseModel *)model ForKey:(NSString *)key;
 *进行归档存储
 */


#import <Foundation/Foundation.h>
#import "YHBaseModelProtocol.h"
@interface YHBaseModel : NSObject<YHBaseModelProtocol>

@end
