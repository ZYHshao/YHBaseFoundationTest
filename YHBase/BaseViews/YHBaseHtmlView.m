//
//  YHBaseHtmlView.m
//  StudyApp
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseHtmlView.h"
#import "RCLabel.h"

@interface YHBaseHtmlView()<YHRTLabelImageDelegate>
{
    RCLabel * _rcLabel;
    //保存属性 用于异步加载完成后刷新
    RTLabelComponentsStructure * _origenComponent;
    __strong NSString * _srt;
    int _size;
    CGSize _viewSize;
}

@end

@implementation YHBaseHtmlView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _rcLabel = [[RCLabel alloc]init];
        [self addSubview:_rcLabel];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rcLabel = [[RCLabel alloc]initWithFrame:frame];
        [self addSubview:_rcLabel];
        _size=12;
    }
    return self;
}
-(void)reSetHtmlStr:(NSString *)htmlStr{
    _srt = htmlStr;
    NSString * htmlFontStr = [NSString stringWithFormat:@"<font size=%d>%@</font>",_size,_srt];
    _rcLabel.imageDelegate=self;
    _rcLabel.frame=CGRectMake(0, 0, self.frame.size.width, 0);
    _origenComponent = [RCLabel extractTextStyle:htmlFontStr IsLocation:NO withRCLabel:_rcLabel];
    _rcLabel.componentsAndPlainText = _origenComponent;
    
    CGSize size = [_rcLabel optimumSize];
    _rcLabel.frame=CGRectMake(0, 0, _rcLabel.frame.size.width, size.height);
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, _rcLabel.frame.size.width, size.height);
}
-(void)YHRTLabelImageSuccess:(RCLabel *)label{
    _origenComponent = [RCLabel extractTextStyle:_srt IsLocation:NO withRCLabel:_rcLabel];
    _rcLabel.componentsAndPlainText = _origenComponent;
    
    CGSize size = [_rcLabel optimumSize];
    _rcLabel.frame=CGRectMake(0, 0, _rcLabel.frame.size.width, size.height);
     self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, _rcLabel.frame.size.width, size.height);
    if ([self.delegate respondsToSelector:@selector(YHBaseHtmlView:SizeChanged:)]) {
        [self.delegate YHBaseHtmlView:self SizeChanged:self.frame.size];
    }
}
-(void)setFontSize:(int)size{
    if (_size==size) {
        return;
    }
    _size=size;
    if (_srt) {
        [self reSetHtmlStr:_srt];
        CGSize size = [_rcLabel optimumSize];
        if (CGSizeEqualToSize(size, _viewSize)) {
            return;
        }else{
             _viewSize = size;
            _rcLabel.frame=CGRectMake(0, 0, _rcLabel.frame.size.width, size.height);
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, _rcLabel.frame.size.width, size.height);
            if ([self.delegate respondsToSelector:@selector(YHBaseHtmlView:SizeChanged:)]) {
                [self.delegate YHBaseHtmlView:self SizeChanged:self.frame.size];
            }
        }
    }
}



@end
