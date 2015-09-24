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
 *  @author jaki, 15-09-24 10:09:38
 *
 *  @brief  链接URL
 */
__PROPERTY_NO_STRONG__(NSString *, urlString);
/**
 *  @author jaki, 15-09-24 10:09:55
 *
 *  @brief  请求ID，通过ID来区分请求，防止了通过url来区分请求是url中含有时间戳的问题
 */
__PROPERTY_NO_STRONG__(NSString *, requestIdentity);
/**
 *  @author jaki, 15-09-24 10:09:00
 *
 *  @brief  请求参数字典 get请求可无
 */
__PROPERTY_NO_STRONG__(NSDictionary *, pramaDic);
@end
