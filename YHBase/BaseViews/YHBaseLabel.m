//
//  YHBaseLabel.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHBaseLabel.h"

@implementation YHBaseLabel

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
    _index = 0;
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor andAlignment:(NSTextAlignment)alignment{
    self = [self init];
    self.frame = frame;
    if (title!=nil) {
        self.text = title;
    }
    if (textColor!=nil) {
        self.textColor = textColor;
    }
    if (bgColor!=nil) {
        self.backgroundColor = bgColor;
    }
    self.textAlignment = alignment;
    return self;
}
-(void)setCornerRaidus:(CGFloat)raidus{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = raidus;
}
-(void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}

@end
