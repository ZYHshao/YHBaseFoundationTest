//
//  YHBaseSelfServiceDrawView.m
//  
//
//  Created by user on 15/8/25.
//
//

#import "YHBaseSelfServiceDrawView.h"
@interface YHBaseSelfServiceDrawView()
{
    UIBezierPath * _bezierPath;
    UIPanGestureRecognizer * _panGesture;
    
    //上一个触摸点
    CGPoint _tmpPoint;
    UIColor * _lineColor;
    BOOL _clear;
}
@end
@implementation YHBaseSelfServiceDrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
    [self removeGestureRecognizer:_panGesture];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bezierPath = [UIBezierPath bezierPath];
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        _panGesture.minimumNumberOfTouches=1;
        _panGesture.maximumNumberOfTouches=1;
        [self addGestureRecognizer:_panGesture];
        _tmpPoint = CGPointZero;
        
    }
    return self;
}


-(void)pan:(UIPanGestureRecognizer *)gesture{
    if (_bezierPath==nil) {
        _bezierPath = [UIBezierPath bezierPath];
        
    }
    CGPoint point = [gesture locationInView:self];
    //取中间点 做贝塞尔处理
    CGPoint newPoint = YHBaseMiddlePoint(_tmpPoint, point);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [_bezierPath moveToPoint:point];
    }else if(gesture.state==UIGestureRecognizerStateChanged){
        [_bezierPath addQuadCurveToPoint:newPoint controlPoint:_tmpPoint];
    }
    _tmpPoint=point;
    [self setNeedsDisplay];
    
}
-(void)clearDrawView{
    [self setNeedsDisplay];
}
-(void)setDrawLineColor:(UIColor *)color{
    _lineColor = color;
}

-(void)setDrawLineWidth:(CGFloat)width{
    _bezierPath.lineWidth=width;
}

//重写这个方法
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_lineColor!=nil) {
        [_lineColor setStroke];
    }else{
        [[UIColor blackColor] setStroke];
    }
    [_bezierPath stroke];
}
@end
