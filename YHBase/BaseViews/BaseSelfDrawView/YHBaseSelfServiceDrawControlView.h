//
//  YHBaseSelfServiceDrawControlView.h
//  
//
//  Created by user on 15/8/25.
//
//

#import <UIKit/UIKit.h>

@interface YHBaseSelfServiceDrawControlView : UIView
{
    CGFloat  _height;
    CGFloat  _width;
    CGSize _drawSize;
}
//设置画布大小
-(void)setDrawSize:(CGSize)size;
//设置画布颜色
-(void)setDrawViewBackgroundColor:(UIColor*)color;
//核心画图视图
@property(nonatomic,strong)YHBaseSelfServiceDrawView * drawView;

/**
 *设置画笔属性
 */
-(void)setDrawSettingOfWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 *清空画板
 */
-(void)clearView;

-(void)open;
-(void)close;
@end
