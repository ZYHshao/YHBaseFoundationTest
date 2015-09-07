//
//  YHViewProtocol.h
//  
//
//  Created by user on 15/8/18.
//
//

#import <Foundation/Foundation.h>

@protocol YHViewProtocol <NSObject>
//视图的自定义重载写在这个方法中
-(void)reloadView;
@optional
/**
 *设置圆角度
 */
-(void)setCornerRaidus:(CGFloat)raidus;
/**
 *设置边框
 */
-(void)setBorderWidth:(CGFloat)width andColor:(UIColor*)color;
/**
 *统一加载数据的方法
 */
-(void)creatViewWithData:(id)data;
@end
