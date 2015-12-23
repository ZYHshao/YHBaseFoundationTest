//
//  YHBaseHtmlView.h
//  StudyApp
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//这个类包装了CRLabel的方法，改进了CRLabel，可以异步的加载html中的图片，并且可以带缓存

#import "YHBaseView.h"
@class YHBaseHtmlView;
@protocol YHBaseHtmlViewProcotop <NSObject>
@optional
/**
 *尺寸改变后执行的回调
 */
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView SizeChanged:(CGSize)size;
/**
 *点击超链接后的回调
 */
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView ClickLink:(NSString *)url;
@end





@interface YHBaseHtmlView : YHBaseView
/**
 *加载Html字符串 
 *
 *注意，如果要设置一些属性，必须再设置后调用此方法
 */
-(void)reSetHtmlStr:(NSString *)htmlStr;
/**
 *设置字体的大小
 */
-(void)setFontSize:(int)size;
/**
 *设置字体颜色
 */
@property(nonatomic,strong)UIColor * fontColor;
/**
 *设置超链接文字颜色
 */
@property(nonatomic,strong)UIColor * linkingColor;
/**
 *是否显示点击超链接的阴影效果
 */
@property(nonatomic,assign)BOOL showLinkingShadow;
/**
 *设置超链接字体大小
 */
@property(nonatomic,assign)int linkingSize;
/**
 *设置是否显示下划线
 */
@property(nonatomic,assign)BOOL showUnderLine;
@property(nonatomic,weak)id<YHBaseHtmlViewProcotop>delegate;
@end
