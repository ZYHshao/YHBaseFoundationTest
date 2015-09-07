//
//  YHBaseActivityIndicatorView.h
//  
//
//  Created by user on 15/8/19.
//
//

#import <UIKit/UIKit.h>

@interface YHBaseActivityIndicatorView : UIView<YHSingletonProcotol,YHViewProtocol>
//呼出和移去的方法
-(void)show;
-(void)unShow;
@end
