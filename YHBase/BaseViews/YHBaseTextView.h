//
//  YHBaseTextView.h
//  
//
//  Created by user on 15/8/26.
//
//texView的基类，带placeholder等扩展功能

#import <UIKit/UIKit.h>

@interface YHBaseTextView : UITextView<YHViewProtocol>
@property(nonatomic,strong)NSString * placeHolder;
@end
