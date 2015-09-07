//
//  YHBaseHttpRequestObject.h
//  
//
//  Created by user on 15/8/18.
//
//请求的对象类

#import <Foundation/Foundation.h>

@interface YHBaseHttpRequestObject : NSObject
/**
 *链接URL
 */
__PROPERTY_NO_STRONG__(NSString *, urlString);
/**
 *请求ID，通过ID来区分请求，防止了通过url来区分请求是url中含有时间戳的问题
 */
__PROPERTY_NO_STRONG__(NSString *, requestIdentity);
/**
 *请求参数字典 get请求可无
 */
__PROPERTY_NO_STRONG__(NSDictionary *, pramaDic);
@end
