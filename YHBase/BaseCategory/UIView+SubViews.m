//
//  UIView+SubViews.m
//  StudyApp
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "UIView+SubViews.h"

@implementation UIView (SubViews)
-(void)removeAllSubviews{
    NSArray * array = [self subviews];
    for (UIView * sub in array) {
        [sub removeFromSuperview];
    }
}
@end
