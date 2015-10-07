//
//  YHBaseDefaul.h
//  YHBaseFoundationTest
//
//  Created by jaki on 15/9/24.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef YHBaseFoundationTest_YHBaseDefaul_h
#define YHBaseFoundationTest_YHBaseDefaul_h

//=============================常用宏============================
//屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//判断系统版本的宏
#define DEVICE_IOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)&&\
([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0))
#define DEVICE_IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)&&\
([[[UIDevice currentDevice] systemVersion] floatValue] <= 8.0))
#define DEVICE_IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)&&\
([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0))

//=============================快捷定义宏=========================//
#define __PROPERTY_NO_COPY__(type,object) @property(nonatomic,copy)type object
#define __PROPERTY_AT_COPY__(type,object) @property(atomic,copy)type object
#define __PROPERTY_NO_STRONG__(type,object) @property(nonatomic,strong)type object
#define __PROPERTY_AT_STRONG__(type,object) @property(nonatomic,strong)type object

#define __PROPERTY_NO_ASSIGN__(type,object) @property(nonatomic,assign)type object
#define __PROPERTY_AT_ASSIGN__(type,object) @property(atomic,assign)type object
#define __PROPERTY_NO_WEAK__(type,object) @property(nonatomic,weak)type object
#define __PROPERTY_AT_WEAK__(type,object) @property(nonatomic,weak)type object

#define __PROPERTY_NO_STRONG__READLY__(type,object) @property(nonatomic,strong,readonly)type object
#define __PROPERTY_NO_ASSIGN__READLY__(type,object) @property(nonatomic,assign,readonly)type object

#define __PROPERTY_NO_WEAK__READLY__(type,object) @property(nonatomic,weak,readonly)type object

#define __GET_APPDELEGGATE__(del) id del = [UIApplication sharedApplication].delegate;
//定义这个宏方便在block中使用self指针
#define __BLOCK__WEAK__SELF__(sel) __weak id sel =  self
//这个宏没什么卵用 提示开发者这个集合中的参数类型 省去注释的编写
//现在这个宏真的一点用都没有了 在xcode7中支持了泛型集合
/**
 *__PROPERTY_NO_STRONG__(__TYPE__FIT_TO__CLASS([NSString class]) NSArray * , array);
 */
#define __TYPE__FIT_TO__CLASS(...)

/**
 *  @author jaki, 15-09-24 10:09:52
 *
 *  @brief  这个宏省略实现get方法，可以在其中加入自定义的代码，下面两个要结合使用
 */
#define __OBJC_GETTER__START__(type,object) -(type)object{
/**
 *  @author jaki, 15-09-24 10:09:16
 *
 *  @brief  这里添加自定义的处理代码
 */
#define __OBJC_GETTER__END__(object)  return object;\
                                        }






//=============================注册的通知========================//
//错误中心监听的通知
#define YHBASE_ERROR_CENTER_NOTICATION @"YHBaseErrorCenterNotication"
//播放引擎播放状态的通知
#define YHBASE_AVFOUNDATION_PLAYER_STATE @"YHBaseAVFoundationPlayState"

#define YH_BASE_TOPIC_CHANGE_TOPIC_NOTICATION @"YHTopicChangeTopicNotication"

#endif
