//
//  YHBaseListViewItem.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHBaseListViewItem.h"
@interface YHBaseListViewItem(){
    UITapGestureRecognizer * _tap;
}
@end
@implementation YHBaseListViewItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    [self removeGestureRecognizer:_tap];
    _action=nil;
}

-(instancetype)initWithTitle:(NSString *)title titleImage:(NSString *)image{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text=title;
        _titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
        [self addSubview:_titleLabel];
        [self addSubview:_titleImageView];
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:_tap];
    }
    return self;
}

-(void)tap{
    if (_action) {
        _action();
    }
}
@end
