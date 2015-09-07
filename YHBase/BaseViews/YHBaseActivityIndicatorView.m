//
//  YHBaseActivityIndicatorView.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseActivityIndicatorView.h"

@implementation YHBaseActivityIndicatorView
{
    BOOL _isShow;
    //默认使用系统的，可以在reloadView中自定义
    UIActivityIndicatorView * _defaultActivityView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadView];
    }
    return self;
}

-(void)reloadView{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _defaultActivityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_defaultActivityView startAnimating];
    _defaultActivityView.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self addSubview:_defaultActivityView];

}
+(instancetype)sharedTheSingletion{
    static YHBaseActivityIndicatorView * shared = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}
-(void)show{
    if (_isShow) {
        return;
    }else{
        _isShow=YES;
        __GET_APPDELEGGATE__(delegate);
        [[delegate window] addSubview:self];
        //渐变的动画
        self.alpha=0;
        __BLOCK__WEAK__SELF__(__self);
        [UIView animateWithDuration:0.3 animations:^{
            [__self setAlpha:1];
        }];
    }
}

-(void)unShow{
    if (_isShow) {
       __BLOCK__WEAK__SELF__(__self);
        [UIView animateWithDuration:0.3 animations:^{
            [__self setAlpha:0];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
        _isShow=NO;
    }
}

@end
