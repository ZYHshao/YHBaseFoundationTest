//
//  UIView+Responder.h
//  
//
//  Created by user on 15/9/9.
//
//这个扩展将view与其controller链接起来 解耦项目共的VC

#import <UIKit/UIKit.h>

@interface UIView (Responder)
/**
 *获取试题的承载controller
 *在设计时，可以将许多简单代理回调的模式简化 
 *换成黑盒子式的内部实现
 */
-(UIViewController *)getController;
@end
