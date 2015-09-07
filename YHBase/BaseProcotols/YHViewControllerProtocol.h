//
//  YHViewControllerProtocol.h
//  
//
//  Created by user on 15/8/17.
//
//统一视图的创建方法

#import <Foundation/Foundation.h>

@protocol YHViewControllerProtocol <NSObject>
//加载数据
-(void)YHCreatDate;
//构建视图
-(void)YHCreatView;
@end
