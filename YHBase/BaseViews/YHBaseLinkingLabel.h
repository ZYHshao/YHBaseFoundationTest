//
//  YHBaseLinkingLabel.h
//  YHBaseFoundationTest
//
//  Created by jaki on 15/12/23.
//  Copyright © 2015年 jaki.zhang. All rights reserved.
/**
 *这个类创建可以添加超链接的标签，可以为类似label的某个字段添加交互处理
 */

#import "YHBaseView.h"
#import "YHBaseModel.h"
@class YHBaseLinkingLabelModel;

@protocol YHBaseLinkingLabelProtocol <NSObject>

@optional
/**
 *点击超链接后出发的代理方法 model中有链接地址和文字
 */
-(void)YHBaseLinkingLabelClickLinking:(YHBaseLinkingLabelModel *)model;
/**
 *尺寸改变后出发的方法
 */
-(void)YHBaseLinkingLabelSizeChange:(CGSize)size;
@end

@interface YHBaseLinkingLabel : YHBaseView
/**
 *文字数组 里面存放这文字对应的超链接对象
 */
@property(nonatomic,strong)NSArray<YHBaseLinkingLabelModel *> * textArray;
@property(nonatomic,weak)id<YHBaseLinkingLabelProtocol>delegate;
/**
 *设置文字颜色
 */
@property(nonatomic,strong)UIColor * textColor;
/**
 *设置超链接文字颜色
 */
@property(nonatomic,strong)UIColor * linkColor;
/**
 *设置字体大小
 */
@property(nonatomic,assign)NSUInteger fontSize;
/**
 *设置超链接字体大小
 */
@property(nonatomic,assign)int linkingFontSize;
/**
 *设置是否显示下划线
 */
@property(nonatomic,assign)BOOL isShowUnderLine;
@end

//==============================文字超链接对象======================//
@interface YHBaseLinkingLabelModel : YHBaseModel
/**
 *文字内容
 */
@property(nonatomic,strong)NSString * text;
/**
 *超链接地址 nil则为无
 */
@property(nonatomic,strong)NSString * linking;

@end
