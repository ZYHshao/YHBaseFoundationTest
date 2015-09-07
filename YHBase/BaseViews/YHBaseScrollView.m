//
//  YHBaseScrollView.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHBaseScrollView.h"

@implementation YHBaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadView];
    }
    return self;
}
-(void)reloadView{
    
}
@end
