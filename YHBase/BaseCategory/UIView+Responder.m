//
//  UIView+Responder.m
//  
//
//  Created by user on 15/9/9.
//
//

#import "UIView+Responder.h"

@implementation UIView (Responder)
-(UIViewController *)getController{
    for (UIView * view = [self superview];view ; view = [view superview]) {
        UIResponder * responder = [view nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]||[[responder class] isSubclassOfClass:[UIViewController class]] ) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}
@end
