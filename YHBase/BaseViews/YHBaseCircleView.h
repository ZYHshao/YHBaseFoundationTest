//
//  YHBaseCircleView.h
//  YHBaseFoundationTest
//
//  Created by vip on 16/4/15.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseView.h"

@interface YHBaseCircleView : YHBaseView
//==============下面三个渐变色必须全部设置 否则效果可能与预期不同================//
/**
 *设置圆弧渐变色的起始色
 */
@property(nonatomic,strong)UIColor * minLineColor;
/**
 *设置圆弧渐变色的中间色
 */
@property(nonatomic,strong)UIColor * midLineColor;
/**
 *设置圆弧渐变色的终止色
 */
@property(nonatomic,strong)UIColor * maxLineColor;
/**
 *设置圆弧背景色
 */
@property(nonatomic,strong)UIColor * lineTintColor;
/**
 *设置进度
 */
@property(nonatomic,assign)CGFloat progress;
/**
 *设置线的宽度 max = 20 min = 0.5
 */
@property(nonatomic,assign)CGFloat lineWidth;
/**
 *设置是否显示百分比标签
 */
@property(nonatomic,assign)BOOL showTipLabel;
/**
 *设置百分比标签进度颜色
 */
@property(nonatomic,strong)UIColor * textColor;
/**
 *  @brief 设置进度
 *
 *  @param progress 进度 取值0-1
 *
 *  @param animated 是否显示动画
 *
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
