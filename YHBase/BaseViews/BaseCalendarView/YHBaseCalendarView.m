//
//  YHBaseCalendarView.m
//  
//
//  Created by user on 15/9/6.
//
//

#import "YHBaseCalendarView.h"
#import "YHBaseDateModel.h"
@interface YHBaseCalendarView()<UIScrollViewDelegate>
{
    //星期
    UIView * _headView;
    //日历的展示
    UIView * _bodyViewL;
    UIView * _bodyViewM;
    UIView * _bodyViewR;
    //滑动功能的支持
    UIScrollView * _scrollView;
    NSDate * _today;
    
    YHBaseDateModel * _selectModel;
}
@end
@implementation YHBaseCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)reloadView{
    _currentDate = [NSDate date];
    _today = [NSDate date];
    _selectModel = [[YHBaseDateModel alloc]init];
    _selectModel.year = [NSString stringWithFormat:@"%d",[_today getYear]];
    _selectModel.month =[NSString stringWithFormat:@"%d",[_today getMonth]];
    _selectModel.day = [NSString stringWithFormat:@"%d",[_today getDay]];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(3*self.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    
    _bodyViewL = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_bodyViewL];
    _bodyViewM = [[UIView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width,0,  _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_bodyViewM];
    _bodyViewR = [[UIView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width*2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_bodyViewR];
    
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    _headView.backgroundColor = [UIColor redColor];
    NSArray * weekArray = @[@"SUN",@"MON",@"TUES",@"WED",@"THUR",@"FRI",@"SAT"];
    for (int i=0; i<7; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/7*i, 0, self.frame.size.width/7, 30)];
        if (i!=0&&i!=6) {
            label.backgroundColor = [UIColor redColor];
        }else{
            label.backgroundColor = [UIColor purpleColor];
        }
        label.text=weekArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth=1;
        label.layer.borderColor = [[UIColor grayColor]CGColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.layer.borderColor=[[UIColor grayColor] CGColor];
        label.textColor = [UIColor whiteColor];
        label.layer.borderWidth = 1;
        [_headView addSubview:label];
    }
    [self addSubview:_headView];
    
    [self creatViewWithData:_currentDate onView:_bodyViewM];
    [self creatViewWithData:[YHBaseDateTools getPreviousframDate:_currentDate] onView:_bodyViewL];
    [self creatViewWithData:[YHBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
}
//核心的构造方法
-(void)creatViewWithData:(id)data onView:(UIView *)bodyView{
    NSDate * currentDate = (NSDate *)data;
    //获取当前月有多少天
    int monthNum = (int)[currentDate YHBaseNumberOfDaysInCurrentMonth];
    //获取第一天的日期
    NSDate * firstDate = [currentDate YHBaseFirstDayOfCurrentMonth];
    //确定这一天是周几
    int weekday = [firstDate YHBaseWeekly];
    //确定创建多少行
    int weekRow=0;
    int tmp=monthNum;
    if (weekday!=7) {
        weekRow++;
        tmp=monthNum-(7-weekday);
    }
    weekRow += tmp/7;
    weekRow += (tmp%7)?1:0;
    //开始创建按钮
    /**
     *这里的逻辑是有问题的，应该设计成cell的复用机制，而不应该重复耗性能的创建 有时间在优化
     */
#warning 可以优化哦 
    NSArray * array = [bodyView subviews];
    for (UIView * v in array) {
        [v removeFromSuperview];
    }
    int nextDate = 1;
    //行
    for (int i=0; i<weekRow; i++) {
        //列
        for (int j=0; j<7; j++) {
            //先进行上个月余天的创建
            UIButton * btn;
            if (weekday!=7&&(i*7+j)<weekday) {
                //获取上个月有多少天
                NSDate * preDate = [YHBaseDateTools getPreviousframDate:currentDate];
                int preDays = (int)[preDate YHBaseNumberOfDaysInCurrentMonth];
                btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7*j, self.frame.size.width/7*i, self.frame.size.width/7, self.frame.size.width/7)];
                [btn setTitle:[NSString stringWithFormat:@"%d",preDays-weekday+j+1] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [bodyView addSubview:btn];
            }else if((i*7+j+1-(weekday==7?0:weekday))<=monthNum){
                btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7*j, self.frame.size.width/7*i, self.frame.size.width/7, self.frame.size.width/7)];
                [btn setTitle:[NSString stringWithFormat:@"%d",(i*7+j+1-(weekday==7?0:weekday))] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [bodyView addSubview:btn];
            }else{
                btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7*j, self.frame.size.width/7*i, self.frame.size.width/7, self.frame.size.width/7)];
                [btn setTitle:[NSString stringWithFormat:@"%d",nextDate++] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [bodyView addSubview:btn];
            }
            //将今天的日期标出
            if ([currentDate getYear]==[_today getYear]&&[currentDate getMonth]==[_today getMonth]&&[btn.titleLabel.text intValue]==[_today getDay]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            //是否进行自定义标记
            /**
             *if中的颜色比较 是为了让上月与下月的余日不产生bug
             */
            if (_markArray!=nil) {
                for (int i=0; i<_markArray.count; i++) {
                    YHBaseDateModel * model = _markArray[i];
                    if ([currentDate getYear]==[model.year intValue]&&[currentDate getMonth]==[model.month intValue]&&[btn.titleLabel.text intValue]==[model.day intValue]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                        btn.layer.borderColor = [[UIColor grayColor]CGColor];
                        btn.layer.borderWidth=1;
                    }
                }
            }
            //是否进行选中标记
            if ([_selectModel.year intValue]==[currentDate getYear]&&[_selectModel.month intValue]==[currentDate getMonth]&&[_selectModel.day intValue]==[btn.titleLabel.text intValue]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                btn.backgroundColor = [UIColor cyanColor];
            }
            if (!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                //添加点击事件
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
           
        }
    }
    
}
//这个方法中进行重构
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x==0) {//向前翻页了
        _currentDate = [YHBaseDateTools getPreviousframDate:_currentDate];
        _scrollView.contentOffset=CGPointMake(scrollView.frame.size.width, 0);
        
        [self creatViewWithData:_currentDate onView:_bodyViewM];
        [self creatViewWithData:[YHBaseDateTools getPreviousframDate:_currentDate] onView:_bodyViewL];
        [self creatViewWithData:[YHBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
        
    }else if (scrollView.contentOffset.x==scrollView.frame.size.width){
        
    }else if (scrollView.contentOffset.x==scrollView.frame.size.width*2){
        _currentDate = [YHBaseDateTools getNextMonthframDate:_currentDate];
        _scrollView.contentOffset=CGPointMake(scrollView.frame.size.width, 0);
        
        [self creatViewWithData:_currentDate onView:_bodyViewM];
        [self creatViewWithData:[YHBaseDateTools getPreviousframDate:_currentDate] onView:_bodyViewL];
        [self creatViewWithData:[YHBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
    }
    scrollView.userInteractionEnabled=YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.userInteractionEnabled=NO;
}

//点击事件
-(void)clickBtn:(UIButton *)btn{
    _selectModel.year = [NSString stringWithFormat:@"%d",[_currentDate getYear]];
    _selectModel.month = [NSString stringWithFormat:@"%d",[_currentDate getMonth]];
    _selectModel.day = btn.titleLabel.text;
    [self creatViewWithData:_currentDate onView:_bodyViewM];
    [self creatViewWithData:[YHBaseDateTools getPreviousframDate:_currentDate] onView:_bodyViewL];
    [self creatViewWithData:[YHBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
    if ([self.delegate respondsToSelector:@selector(YHBaseCalendarViewSelectAtDateModel:)]) {
        [self.delegate YHBaseCalendarViewSelectAtDateModel:_selectModel];
    }
    
}

@end
