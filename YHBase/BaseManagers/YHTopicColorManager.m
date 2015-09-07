//
//  YHTopicColorManager.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHTopicColorManager.h"


@implementation YHTopicColorManager
+(instancetype)sharedTheSingletion{
    static YHTopicColorManager * sharedModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedModel = [[YHTopicColorManager alloc] init];
    });
    return sharedModel;
}



-(void)getTopicModel{
    //从本地读取
    int  tp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"topic"]intValue];
    if (tp==0) {
        //默认为白天主题
        tp=dayTime;
    }
    switch (tp) {
        case dayTime://白天模式
        {
            _navColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _bgColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _btnColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            _btnTextColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _navTextColor= [UIColor whiteColor];
            _borderLineColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
            _greyBgColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            _listBgColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        }
            break;
        case nightTime://夜间模式
        {
            _navColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _bgColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            _btnColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _btnTextColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _navTextColor= [UIColor whiteColor];
            _borderLineColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            _greyBgColor = [UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1];
            _listBgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        }
            break;
        default:
            break;
    }
}
+(void)postTopicChangeMessage{
    [[NSNotificationCenter defaultCenter]postNotificationName:YH_BASE_TOPIC_CHANGE_TOPIC_NOTICATION object:nil];
}
@end
