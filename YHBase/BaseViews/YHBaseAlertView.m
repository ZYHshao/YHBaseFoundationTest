//
//  YHBaseAlertView.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseAlertView.h"
//全局的代理和block 伪单例效果
/**
 *可以像普通alert一样创建 也可以使用这个伪单例效果创建
 */
void (^YHBaseAlertBlock)();
YHBaseAlertView * __self__;
@interface YHBaseAlertView()<UIAlertViewDelegate>
@end
@implementation YHBaseAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
    YHBaseAlertBlock=nil;
}

+(void)showWithStyle:(YHBaseAlertViewStyle)style title:(NSString *)title text:(NSString *)text cancleBtn:(NSString *)cancle selectBtn:(NSString *)select andSelectFunc:(void (^)())funBlock{
    if (__self__ == nil) {
        __self__ = [[YHBaseAlertView alloc]init];
    }
    
    switch (style) {
        case YHBaseAlertViewSimple:
        {
            UIAlertView * alert = [[self alloc]initWithTitle:title message:text delegate:__self__ cancelButtonTitle:cancle otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case YHBaseAlertViewNormal:
        {
            UIAlertView * alert = [[self alloc]initWithTitle:title message:text delegate:__self__ cancelButtonTitle:cancle otherButtonTitles:select, nil];
            YHBaseAlertBlock=nil;
            YHBaseAlertBlock=funBlock;
            [alert show];
        }
            break;
        default:
            break;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //取消
            break;
        case 1:
            //确定
            YHBaseAlertBlock();
            break;
        default:
            break;
    }
}
@end
