//
//  YHBaseAlertView.h
//  
//
//  Created by user on 15/8/19.
//
//自动创建弹出简单的提示框

#import <UIKit/UIKit.h>
typedef enum {
    //只有一个取消按钮的提示框
    YHBaseAlertViewSimple,
    //一个取消和一个确定按钮的提示框
    YHBaseAlertViewNormal
}YHBaseAlertViewStyle;
@interface YHBaseAlertView : UIAlertView
/**
 *创建最常用的警告框 使用block 去掉了回调代理显示的繁琐
 */
+(void)showWithStyle:(YHBaseAlertViewStyle)style title:(NSString *)title text:(NSString *)text cancleBtn:(NSString *)cancle selectBtn:(NSString *)select andSelectFunc:(void (^)())funBlock;
@end
