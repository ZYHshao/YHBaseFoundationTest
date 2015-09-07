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
    NSString * _srt;
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
    }
    return self;
}
-(void)reSetHtmlStr:(NSString *)htmlStr{
    _srt = htmlStr;
    _rcLabel.imageDelegate=self;
    _rcLabel.frame=CGRectMake(0, 0, self.frame.size.width, 0);
    _origenComponent = [RCLabel extractTextStyle:htmlStr IsLocation:NO withRCLabel:_rcLabel];
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
    self.frame=_rcLabel.frame;
    if ([self.delegate respondsToSelector:@selector(YHBaseHtmlView:SizeChanged:)]) {
        [self.delegate YHBaseHtmlView:self SizeChanged:self.frame.size];
    }
}

@end
