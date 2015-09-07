//
//  YHBaseView.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHBaseView.h"

@implementation YHBaseView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         [self reloadView];
    }
    return self;
}
-(void)reloadView{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
