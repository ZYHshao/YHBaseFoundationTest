//
//  UIViewController+YHBaseTest.m
//  
//
//  Created by user on 15/9/10.
//
//

#import "UIViewController+YHBaseTest.h"
#import <objc/runtime.h>
@implementation UIViewController (YHBaseTest)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(YHBaseViewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)YHBaseViewWillAppear:(BOOL)animated {
    [self YHBaseViewWillAppear:animated];
    YHBaseProcessLog(@"YHBaseTest:ViewWillAppear: %@", self);
    
}

@end
