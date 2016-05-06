//
//  YHBaseHeaderAnimatedViewController.h
//  YHBaseFoundationTest
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
/*
 *  这个视图控制器创建出带缩放头图效果的视图控制器
 *  tip：
 *      1.这个视图控制器如果是被导航push出来的 则内部会使用假导航进行渐隐模拟
 *      2.这个视图控制器如果是被present出来的 则不会出现假导航栏
 *      3.这个视图控制器中自带一个TableView 设置TableView的头图不会影响原动画效果
 *
 */

#import "YHBaseTableViewController.h"
/**
 *  这个枚举设置头图动画滑动的速度等级
 */
typedef enum {
    YHBaseHeaderAnimatedLevelSlow,
    YHBaseHeaderAnimatedLevelNormal,
    YHBaseHeaderAnimatedLevelFast
}YHBaseHeaderAnimatedLevel;
@interface YHBaseHeaderAnimatedViewController : YHBaseTableViewController
/**
 *  设置动画头图图片
 */
@property(nonatomic,strong)UIView * animatedHeaderView;
/**
 *  设置TableView的头视图 
 *
 *  注意：设置tableView的头视图不能够在使用tableHeatherView方法 要使用这个属性设置
 *
 */
@property(nonatomic,strong)UIView * tableHeaderView;
/**
 *  设置动画头图高度
 *
 *  这个属性如果不设置或者设置为0 则默认会使用设置的image图片比例
 *
 */
@property(nonatomic,assign)CGFloat headerHeight;
/**
 *
 *  设置动画滑动速率
 */
@property(nonatomic,assign)YHBaseHeaderAnimatedLevel animatedlevel;
/**
 *
 *  设置头图可方法的最大scrollView偏移量 默认为40
 *
 */
@property(nonatomic,assign)CGFloat maxScrollOffset;
/**
 *  设置是否带渐隐效果
 *
 */
@property(nonatomic,assign)BOOL alphaAnimated;
/**
 *  设置最小渐变到的alpha渐隐值 <0 >1之间 默认为0.5
 *
 */
@property(nonatomic,assign)CGFloat minAlpha;
/**
 *
 *  是否显示毛玻璃模糊效果
 *
 */
@property(nonatomic,assign)BOOL bluerAnimated;
/**
 *
 *  设置最大小模糊度 默认为1 
 *
 */
@property(nonatomic,assign)CGFloat maxBluer;
/**
 *  设置导航栏颜色 默认白色
 *
 */
@property(nonatomic,strong)UIColor * naviColor;
/**
 *  设置导航左侧按钮数组 如果不设置 会自动带一个返回按钮
 *
 */
@property(nonatomic,strong)NSArray * leftBarButtons;
/**
 *  设置导航左侧按钮数组 如果不设置 会自动带一个返回按钮
 *
 */
@property(nonatomic,strong)NSArray * rightBarButtons;
/**
 *  这个方法在修改了头图相关属性后 需要调用刷新
 *
 *  注意：如果重新设置了TableView的tableheaderView属性 也需要调用这个方法刷新
 *
 */
-(void)reloadAnimatedView;
@end
