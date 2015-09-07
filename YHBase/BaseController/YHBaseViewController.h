//
//  YHBaseViewController.h
//  
//
//  Created by user on 15/8/17.
//
//视图控制器的基类

#import <UIKit/UIKit.h>
#import "YHViewControllerProtocol.h"
#import "YHTopicColorManager.h"
@interface YHBaseViewController : UIViewController<YHViewControllerProtocol,YHTopicProcotol>

@end
