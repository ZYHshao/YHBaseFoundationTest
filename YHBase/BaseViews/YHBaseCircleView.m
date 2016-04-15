//
//  YHBaseCircleView.m
//  YHBaseFoundationTest
//
//  Created by vip on 16/4/15.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseCircleView.h"

@implementation YHBaseCircleView
{
    float _contentWidth;
    float _contentHeight;
    //形状layer
    CAShapeLayer * _shapeLayer;
    //颜色渐变layer
    CAGradientLayer * _gradLayerR;
    CAGradientLayer * _gradLayerL;
    CALayer * _gradLayer;
    //内容layer
    CAShapeLayer * _contentLayer;
    UILabel * _tipLabel;
    //专门用来更新label
    NSTimer * _timer;
    float _oldProgress;
    int old;
    int new;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)reloadView{
    self.backgroundColor = [UIColor clearColor];
    //取设置的frame的最小长或款作为内容区域
    _contentWidth = _contentHeight = CGRectGetWidth(self.frame)>CGRectGetHeight(self.frame)?CGRectGetHeight(self.frame):CGRectGetWidth(self.frame);
    //创建内容layer
    _contentLayer = [CAShapeLayer layer];
    _contentLayer.bounds = CGRectMake(0, 0, _contentWidth, _contentHeight);
    _contentLayer.position = CGPointMake(_contentWidth/2, _contentHeight/2);
    _contentLayer.backgroundColor = [UIColor clearColor].CGColor;
    //进行边界描绘 默认线宽为4px
    UIBezierPath * pathT = [UIBezierPath bezierPathWithArcCenter:_contentLayer.position radius:_contentWidth/2-2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    _contentLayer.path = pathT.CGPath;
    //默认填充颜色为白色
    _contentLayer.fillColor = [UIColor whiteColor].CGColor;
    _contentLayer.lineWidth = 4;
    _contentLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:_contentLayer];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.bounds = CGRectMake(0, 0, _contentWidth, _contentHeight);
    _shapeLayer.position = CGPointMake(_contentWidth/2, _contentHeight/2);
    _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
//    _shapeLayer.lineCap  = kCALineCapRound;
    //进行边界描绘 默认线宽为4px
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:_shapeLayer.position radius:_contentWidth/2-2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 4;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //默认黄转橙转红的边界线 分别由两个gradLayer进行控制
    _gradLayer = [CALayer layer];
    _gradLayer.bounds = _contentLayer.bounds;
    _gradLayer.position = _contentLayer.position;
    _gradLayer.backgroundColor = [UIColor clearColor].CGColor;
    _gradLayerL = [CAGradientLayer layer];
    _gradLayerL.bounds = CGRectMake(0, 0, _contentWidth/2, _contentHeight);
    _gradLayerL.locations = @[@0.6];
    [_gradLayerL setColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor orangeColor].CGColor]];
    _gradLayerL.position = CGPointMake(_gradLayerL.bounds.size.width/2, _gradLayerL.bounds.size.height/2);
   [_gradLayer addSublayer:_gradLayerL];
    _gradLayerR = [CAGradientLayer layer];
    _gradLayerR.locations = @[@0.6];
    _gradLayerR.bounds = CGRectMake(_contentWidth/2, 0, _contentWidth/2, _contentHeight);
    [_gradLayerR setColors:@[(id)[UIColor yellowColor].CGColor,(id)[UIColor orangeColor].CGColor]];
    _gradLayerR.position = CGPointMake(_gradLayerR.bounds.size.width/2+_contentWidth/2, _gradLayerR.bounds.size.height/2);
    [_gradLayer addSublayer:_gradLayerR];
    [_gradLayer setMask:_shapeLayer];
    [_contentLayer addSublayer:_gradLayer];
    
    
    //setter方法初始化
    _minLineColor = [UIColor yellowColor];
    _midLineColor = [UIColor orangeColor];
    _maxLineColor = [UIColor redColor];
    _lineTintColor = [UIColor grayColor];
    _progress = 1;
    _lineWidth = 4;
    _lineTintColor = [UIColor grayColor];
    _textColor = [UIColor orangeColor];
    _oldProgress = 1;
    //创建tiplabel
    [self creatTipLabel];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
   
}

-(void)removeFromSuperview{
    _timer.fireDate = [NSDate distantFuture];
    [_timer invalidate];
    _timer =nil;
    [super removeFromSuperview];
}
-(void)updateLabel{
    if (old<new) {
        old++;
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d%%",old]];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, attri.length-1)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(attri.length-1, 1)];
        [attri addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, attri.length)];
        _tipLabel.attributedText = attri;
    }else if (old>new){
        old--;
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d%%",old]];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, attri.length-1)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(attri.length-1, 1)];
        [attri addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, attri.length)];
        _tipLabel.attributedText = attri;
    }else{
        _timer.fireDate = [NSDate distantFuture];
    }
}
-(void)setMinLineColor:(UIColor *)minLineColor{
    _minLineColor = minLineColor;
    [_gradLayerR setColors:@[(id)_minLineColor.CGColor,(id)_midLineColor.CGColor]];
    [_gradLayerL setColors:@[(id)_maxLineColor.CGColor,(id)_midLineColor.CGColor]];
}
-(void)setMidLineColor:(UIColor *)midLineColor{
    _midLineColor = midLineColor;
    [_gradLayerR setColors:@[(id)_minLineColor.CGColor,(id)_midLineColor.CGColor]];
    [_gradLayerL setColors:@[(id)_maxLineColor.CGColor,(id)_midLineColor.CGColor]];
}
-(void)setMaxLineColor:(UIColor *)maxLineColor{
    _maxLineColor = maxLineColor;
    [_gradLayerR setColors:@[(id)_minLineColor.CGColor,(id)_midLineColor.CGColor]];
    [_gradLayerL setColors:@[(id)_maxLineColor.CGColor,(id)_midLineColor.CGColor]];
}
-(void)setTintColor:(UIColor *)tintColor{
    _lineTintColor = tintColor;
    _contentLayer.strokeColor = tintColor.CGColor;
}
-(void)setProgress:(CGFloat)progress{
    _oldProgress = _progress;
    _progress=progress;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = progress>1?1:progress;
    NSMutableAttributedString * attri ;
    if (progress==1) {
        attri = [[NSMutableAttributedString alloc]initWithString:@"100%"];
    }else{
        attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%2d%%",(int)(progress*100)]];
    }
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, attri.length-1)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(attri.length-1, 1)];
    [attri addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, attri.length)];
    _tipLabel.attributedText = attri;
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    _oldProgress = _progress;
    _progress = progress;
    old = (int)(_oldProgress*100);
    new = (int)(_progress*100);
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.toValue = progress>1?@1:@(progress);
    ani.duration = 0.3;
    ani.delegate=self;
    ani.fillMode=kCAFillModeForwards;
    ani.removedOnCompletion=NO;
    [_shapeLayer addAnimation:ani forKey:nil];
    _timer.fireDate = [NSDate distantPast];
    
}
- (void)dealloc
{
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [_shapeLayer removeAllAnimations];
        _shapeLayer.strokeEnd = _progress>1?1:_progress;
    }
}
-(void)setLineWidth:(CGFloat)lineWidth{
    if (lineWidth<0.5) {
        lineWidth=0.5;
    }
    if (lineWidth>20) {
        lineWidth = 20;
    }
    _lineWidth = lineWidth;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:_shapeLayer.position radius:_contentWidth/2-lineWidth/2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = lineWidth;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_gradLayer setMask:_shapeLayer];
    UIBezierPath * pathT = [UIBezierPath bezierPathWithArcCenter:_contentLayer.position radius:_contentWidth/2-lineWidth/2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    _contentLayer.path = pathT.CGPath;
    _contentLayer.lineWidth = lineWidth;

}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithAttributedString:_tipLabel.attributedText];
    [attr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, attr.length)];
    _tipLabel.attributedText = attr;
}
-(void)creatTipLabel{
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sqrt(2)/2*(_contentWidth-_lineWidth*2), sqrt(2)/2*(_contentWidth-_lineWidth*2))];
    _tipLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:@"100%"];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 3)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3, 1)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 4)];
    _tipLabel.attributedText = attri;
    [self addSubview:_tipLabel];
}


@end
