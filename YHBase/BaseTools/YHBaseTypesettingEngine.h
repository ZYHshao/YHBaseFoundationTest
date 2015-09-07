//
//  YHBaseTypesettingEngine.h
//  
//
//  Created by user on 15/8/24.
//
//这是一个图文混排的引擎基类，通过定义一些分隔符进行图文混排

/**
 *这个枚举定义一些混排的类型
 */
typedef enum {
    YHBaseTypesettingImage//图片的混排
}YHBaseTypesettingType;

#import <Foundation/Foundation.h>

@interface YHBaseTypesettingEngine : NSObject
@property(nonatomic,strong)NSArray * YHBaseTypesettingEngineModelArray;
@property(nonatomic,strong)NSString * mainText;
/**
 *初始化方法，用一个格式化的字符串进行初始化
 */
-(instancetype)initWithText:(NSString *)text;
/**
 *这个函数会返回 按顺序排列的对应控件的载体
 *例如 将替换图片的位置 转换成imageView 这个数组中将返回按循序的所有混排的imageView
 */
-(NSArray *)getTheTypesettingNode:(YHBaseTypesettingType)type;
/**
 *这个方法将返回替换排版后的view空视图
 */
-(UIView *)getTheTypesettingView;
/**
 *替换的model模型数组
 */
-(void)setModelArray:(NSArray *)modelArray;

/**
 *启动引擎 返回为yes则表明布局成功
 */
-(BOOL)startEngineInSize:(CGSize)size;

@end

//所替换类型的model
@interface YHBaseTypesettingEngineModel : NSObject
@property(nonatomic,strong)NSString *field;
@property(nonatomic,assign)YHBaseTypesettingType type;
@end






