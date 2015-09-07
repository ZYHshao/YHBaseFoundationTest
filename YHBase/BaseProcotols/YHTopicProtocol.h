//
//  YHTopicProtocol.h
//  
//
//  Created by user on 15/8/17.
//
//

#import <Foundation/Foundation.h>
/**
 *这里定义主题的风格
 */
typedef enum {
    dayTime=1,//白天
    nightTime//夜间
}YHTopicModel;
@protocol YHTopicProcotol <NSObject>
//所有可以更换主题的界面必须遵守这个协议调用并实现如下方法
//将视图中控件的颜色摄住部分全部放在这个方法中
@required
-(void)useYHTopicToCreatViewWithModel;
@end
