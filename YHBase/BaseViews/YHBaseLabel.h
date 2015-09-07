//
//  YHBaseLabel.h
//  
//
//  Created by user on 15/8/18.
//
//

#import <UIKit/UIKit.h>

@interface YHBaseLabel : UILabel<YHViewProtocol>
/**
 *类似tag值，默认为0
 */
@property(nonatomic,assign)unsigned int index;
/**
 *自定义的初始化方法
 *其中参数除了frame和alignment均可为nil
 */
-(instancetype)initWithFrame:(CGRect)frame
               title:(NSString *)title
           textColor:(UIColor *)textColor
     backgroundColor:(UIColor *)bgColor
        andAlignment:(NSTextAlignment)alignment;
@end
