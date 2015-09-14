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

/**
 *尺寸改变后执行的回调
 */
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView SizeChanged:(CGSize)size;

@end





@interface YHBaseHtmlView : YHBaseView

-(void)reSetHtmlStr:(NSString *)htmlStr;
/**
 *设置字体的大小
 */
-(void)setFontSize:(int)size;


@property(nonatomic,weak)id<YHBaseHtmlViewProcotop>delegate;
@end
