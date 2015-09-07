//
//  YHBaseTextView.m
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHBaseTextView.h"
@interface YHBaseTextView()
{
    UILabel * _placeHolderLabel;
}
@end
@implementation YHBaseTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
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

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
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
    _placeHolderLabel = [[UILabel alloc]init];
    [self addSubview:_placeHolderLabel];
    _placeHolderLabel.backgroundColor=[UIColor clearColor];
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.numberOfLines=0;
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEdit) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEdit) name:UITextViewTextDidEndEditingNotification object:nil];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self changeEdit];
}
-(void)changeEdit{
    if (self.text.length>0) {
        _placeHolderLabel.hidden=YES;
    }else{
        _placeHolderLabel.hidden=NO;
    }
}
-(void)setCornerRaidus:(CGFloat)raidus{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = raidus;
}
-(void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    _placeHolderLabel.text=placeHolder;
    CGSize size = [YHBaseGeometryTools getLabelSize:_placeHolderLabel inConstrainedSize:CGSizeMake(self.frame.size.width-10, self.frame.size.height-5)];
    _placeHolderLabel.frame=CGRectMake(5, 5, size.width, size.height);
}
@end
