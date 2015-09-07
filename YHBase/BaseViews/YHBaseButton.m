//
//  YHBaseButton.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHBaseButton.h"

@implementation YHBaseButton

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
-(void)dealloc{
    btnBlock = nil;
}

-(instancetype)initWithFrame:(CGRect)frame
             backgroundImage:(UIImage *)image
             backgroundColor:(UIColor *)bgColor
                   textColor:(UIColor *)textColor
                   titleText:(NSString *)title
               andClickBlock:(void (^)(YHBaseButton *))block{
    self = [self init];
    self.frame = frame;
    if (image!=nil) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (bgColor!=nil) {
        self.backgroundColor = bgColor;
    }
    if (textColor!=nil) {
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (title!=nil) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    if (block!=nil) {
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btnBlock = block;
        
    }
    return self;
}
-(void)click:(id)sender{
    btnBlock(sender);
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
