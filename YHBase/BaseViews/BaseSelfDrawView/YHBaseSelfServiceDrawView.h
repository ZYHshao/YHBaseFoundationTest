//
//  YHBaseSelfServiceDrawView.h
//  
//
//  Created by user on 15/8/25.
//
//这是一个涂鸦板控件

#import <UIKit/UIKit.h>

@interface YHBaseSelfServiceDrawView : UIView
/**
 *设置线的宽度
 */
-(void)setDrawLineWidth:(CGFloat)width;
/**
 *设置线的颜色
 */
-(void)setDrawLineColor:(UIColor *)color;
/**
 *清空画板
 */
-(void)clearDrawView;
@end
