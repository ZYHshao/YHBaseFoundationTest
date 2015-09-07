//
//  YHBaseButton.h
//  
//
//  Created by user on 15/8/18.
//
//使用block的方式封装的button，便于循环创建大量简单按钮。省去复杂的tag机制

#import <UIKit/UIKit.h>
#import "YHViewProtocol.h"
@interface YHBaseButton : UIButton<YHViewProtocol>
{
     void (^btnBlock)(YHBaseButton *);
}
/**
 *类似tag值，默认为0
 */
@property(nonatomic,assign)unsigned int index;
/**
 *自定义的创建方法，将点击事件封装为block
 *@param frame 位置尺寸
 *@param image 背景图案 可以为nil
 *@param bgColor 背景颜色 可以为nil
 *@param textColor 文字颜色 可以为nil
 *@param title 标题 可以为nil
 *@param block 点击的回调
 *这些属性均是在Normal状态下,触发方法的回调为TouchUpInside
 */
-(instancetype)initWithFrame:(CGRect)frame
             backgroundImage:(UIImage *)image
             backgroundColor:(UIColor *)bgColor
                   textColor:(UIColor *)textColor
                   titleText:(NSString *)title
               andClickBlock:(void(^)(YHBaseButton *btn))block;



@end
