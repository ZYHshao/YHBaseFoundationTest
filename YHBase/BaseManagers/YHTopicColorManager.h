//
//  YHTopicColorManager.h
//  
//
//  Created by user on 15/8/17.
//
//具体的主题对象,单例

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHSingletonProcotol.h"
#import "YHTopicProtocol.h"
@interface YHTopicColorManager : NSObject<YHSingletonProcotol>


@property(nonatomic,readonly)UIColor * bgColor;
@property(nonatomic,readonly)UIColor * navColor;
@property(nonatomic,readonly)UIColor * btnColor;
@property(nonatomic,readonly)UIColor * labelColor;
@property(nonatomic,readonly)UIColor * textColor;
@property(nonatomic,readonly)UIColor * btnTextColor;
@property(nonatomic,readonly)UIColor * navTextColor;
@property(nonatomic,readonly)UIColor * borderLineColor;
@property(nonatomic,readonly)UIColor * greyBgColor;
@property(nonatomic,readonly)UIColor * listBgColor;
/**
 *使用之前需先调用这个方法进行设置主题
 */
-(void)getTopicModel;


/**
 *发送更改主题的通知
 */
+(void)postTopicChangeMessage;
@end
