//
//  YHBaseLinkingLabel.m
//  YHBaseFoundationTest
//
//  Created by jaki on 15/12/23.
//  Copyright © 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseLinkingLabel.h"
@interface YHBaseLinkingLabel()<YHBaseHtmlViewProcotop>
@end

@implementation YHBaseLinkingLabel
{
    YHBaseHtmlView * _label;
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
        _label = [[YHBaseHtmlView alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
         _label.delegate=self;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _label = [[YHBaseHtmlView alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
         _label.delegate=self;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[YHBaseHtmlView alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        _label.delegate=self;
    }
    return self;
}

-(void)setTextArray:(NSArray<YHBaseLinkingLabelModel *> *)textArray{
    _textArray = textArray;
    //进行html转换
    NSString * htmlString = [self transLinkingDataToHtmlStr:textArray];
    [_label reSetHtmlStr:htmlString];
    
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _label.fontColor = textColor;
}
-(void)setLinkColor:(UIColor *)linkColor{
    _linkColor = linkColor;
    _label.linkingColor = linkColor;
}
-(void)setFontSize:(NSUInteger)fontSize{
    _fontSize = fontSize;
    [_label setFontSize:(int)fontSize];
}
-(void)setLinkingFontSize:(int)linkingFontSize{
    _linkingFontSize = linkingFontSize;
    [_label setLinkingSize:linkingFontSize];
}
-(void)setIsShowUnderLine:(BOOL)isShowUnderLine{
    _isShowUnderLine = isShowUnderLine;
    [_label setShowUnderLine:isShowUnderLine];
}
-(NSString *)transLinkingDataToHtmlStr:(NSArray<YHBaseLinkingLabelModel *> *)data{
    NSMutableString * mutStr = [[NSMutableString alloc]init];
    for (int i=0; i<data.count; i++) {
        YHBaseLinkingLabelModel * model = data[i];
        if (!model.linking) {
            [mutStr appendString:model.text];
        }else {
            [mutStr appendString:@"<a href="];
            [mutStr appendString:model.linking];
            [mutStr appendString:@">"];
            [mutStr appendString:model.text];
            [mutStr appendString:@"</a>"];
        }
    }
    return mutStr;
}

#pragma mark delegate
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView ClickLink:(NSString *)url{
    for (YHBaseLinkingLabelModel * model in _textArray) {
        if ([model.linking isEqualToString:url]) {
            if ([self.delegate respondsToSelector:@selector(YHBaseLinkingLabelClickLinking:)]) {
                [self.delegate YHBaseLinkingLabelClickLinking:model];
                return;
            }
        }
    }
}

-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView SizeChanged:(CGSize)size{
    if ([self.delegate respondsToSelector:@selector(YHBaseLinkingLabelSizeChange:)]) {
        [self.delegate YHBaseLinkingLabelSizeChange:size];
    }
}
@end


@implementation YHBaseLinkingLabelModel


@end
