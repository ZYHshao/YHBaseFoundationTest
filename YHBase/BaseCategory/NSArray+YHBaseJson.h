//
//  NSArray+YHBaseJson.h
//  
//
//  Created by user on 15/9/2.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (YHBaseJson)
//将数组转为json
-(NSString*)transToJsonString:(YHBaseJosnStyle)style;
@end
