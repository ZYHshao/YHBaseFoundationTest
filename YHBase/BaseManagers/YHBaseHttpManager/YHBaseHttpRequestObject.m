//
//  YHBaseHttpRequestObject.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHBaseHttpRequestObject.h"

@implementation YHBaseHttpRequestObject
/**
 *  @author jaki, 15-09-24 10:09:47
 *
 *  @brief  将url进行utf8的处理
 */
__OBJC_GETTER__START__(NSString *, urlString)
_urlString = [_urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
__OBJC_GETTER__END__(_urlString);

@end
