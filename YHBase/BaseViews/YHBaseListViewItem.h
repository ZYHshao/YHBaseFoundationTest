//
//  YHBaseListViewItem.h
//  
//
//  Created by user on 15/8/31.
//
//菜单按钮

#import "YHBaseView.h"

@interface YHBaseListViewItem : YHBaseView
-(instancetype)initWithTitle:(NSString *)title titleImage:(NSString *)image;
/**
 *标题label
 */
@property(nonatomic,strong)UILabel * titleLabel;
/**
 *标题image
 */
@property(nonatomic,strong)UIImageView * titleImageView;

/**
 *tip : 永远不要显式的使用这个参数
 */
@property(nonatomic,strong)void(^action)();

@end
