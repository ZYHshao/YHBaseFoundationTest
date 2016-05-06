//
//  YHBaseAnimatedNavigationViewController.m
//  YHBaseFoundationTest
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseHeaderAnimatedViewController.h"

@interface YHBaseHeaderAnimatedViewController ()
{
    //承载视图
    UIView * _privteBGHeaderView;
    //宽高比例
    CGFloat _privteRate;
    //原始宽高
    CGFloat _privteOriWidth;
    CGFloat _privteOriHeught;
    UIVisualEffectView * _blurView;
    UINavigationBar * _naviBar;
}
@end

@implementation YHBaseHeaderAnimatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//对导航进行处理
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self showNavigationBar];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
-(void)showNavigationBar{
    if (_naviBar==nil) {
        _naviBar = [[UINavigationBar alloc]init];
        [self.view addSubview:_naviBar];
        [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@64);
        }];
        [_naviBar setBackgroundImage:[UIImage imageNamed:@"clear"] forBarMetrics:UIBarMetricsDefault];
        [_naviBar setShadowImage:[UIImage imageNamed:@"clear"]];
        _naviBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        UINavigationItem * item = [[UINavigationItem alloc]initWithTitle:self.title];
        _naviBar.items = @[item];
        item.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popToLast)];
    }
    if (self.animatedHeaderView==nil) {
        _naviBar.hidden=YES;
    }else{
        _naviBar.hidden=NO;
    }
}
-(void)popToLast{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)YHCreatView{
    [super YHCreatView];
    if (self.maxScrollOffset==0) {
        self.maxScrollOffset=40;
    }
    if (self.minAlpha==0) {
        self.minAlpha = 0.5;
    }
    if (self.maxBluer==0) {
        self.maxBluer = 1;
    }
    _privteBGHeaderView = [[UIView alloc]init];
    _privteBGHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    _blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self reloadAnimatedView];
}

-(void)reloadAnimatedView{
    CGFloat viewH=0;
    CGFloat aniH=0;
    for (UIView * view in _privteBGHeaderView.subviews) {
        [view removeFromSuperview];
    }
    if (self.tableHeaderView) {
        viewH = viewH+self.tableHeaderView.bounds.size.height;
        [_privteBGHeaderView addSubview:self.tableHeaderView];
    }
    if (self.animatedHeaderView) {
        _privteRate = self.animatedHeaderView.frame.size.width/self.animatedHeaderView.frame.size.height;
        [self.animatedHeaderView addSubview:_blurView];
        [_blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            
        }];
        _blurView.alpha=0;
        _privteOriWidth = self.animatedHeaderView.frame.size.width;
        _privteOriHeught = self.animatedHeaderView.frame.size.height;
        if (self.headerHeight!=0) {
            viewH+=self.headerHeight;
            aniH = self.headerHeight;
        }else{
            viewH+=self.view.frame.size.width/self.animatedHeaderView.bounds.size.width*self.animatedHeaderView.frame.size.height;
            aniH = self.animatedHeaderView.bounds.size.height;
        }
        [self.view insertSubview:self.animatedHeaderView atIndex:0];
    }
    self.tableHeaderView.frame=CGRectMake(0, aniH, self.tableHeaderView.frame.size.width, self.tableHeaderView.frame.size.height);
    _privteBGHeaderView.frame=CGRectMake(0, 0, self.view.frame.size.width, viewH);
    self.tableView.tableHeaderView = _privteBGHeaderView;
}
-(void)setAnimatedHeaderView:(UIView *)animatedHeaderView{
    if (animatedHeaderView==nil) {
        if (_animatedHeaderView) {
            [_animatedHeaderView removeFromSuperview];
        }
    }
    _animatedHeaderView = animatedHeaderView;
    
}
-(void)setMinAlpha:(CGFloat)minAlpha{
    if (minAlpha<=0) {
        minAlpha=0.001;
    }
    if (minAlpha>=1) {
        minAlpha=0.999;
    }
    _minAlpha=minAlpha;
}
-(void)setMaxBluer:(CGFloat)maxBluer{
    if (maxBluer<=0) {
        maxBluer = 0.001;
    }
    if (maxBluer>=1) {
        maxBluer = 0.999;
    }
    _maxBluer = maxBluer;
}
-(void)setNaviColor:(UIColor *)naviColor{
    _naviColor = naviColor;
    _naviBar.backgroundColor = naviColor;
}
-(void)setLeftBarButtons:(NSArray *)leftBarButtons{
    _naviBar.topItem.leftBarButtonItems = leftBarButtons;
    _leftBarButtons = leftBarButtons;
}
-(void)setRightBarButtons:(NSArray *)rightBarButtons{
    _naviBar.topItem.rightBarButtonItems = rightBarButtons;
    _rightBarButtons = rightBarButtons;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.animatedHeaderView==nil) {
        return;
    }
    if (self.tableView==scrollView) {
        //获取到偏移量 默认两倍
        CGFloat offset = scrollView.contentOffset.y*2;
        //如果小于0 则进行形变拉伸操作
        if (offset<=0) {
            
            if (offset<-self.maxScrollOffset*2) {
               
            }else{
                CGFloat height = _privteOriHeught+abs((int)offset);
                CGFloat width = height*_privteRate;
                self.animatedHeaderView.frame = CGRectMake(self.view.frame.size.width/2-width/2, offset/2, width, height);
            }
            if (_naviBar) {
                if (_naviBar.shadowImage==nil) {
                     [_naviBar setShadowImage:[UIImage imageNamed:@"clear"]];
                }
            }
        }else{
            //如果大于零 进行推出操作
            if (self.animatedlevel==YHBaseHeaderAnimatedLevelSlow) {
                //慢速
                self.animatedHeaderView.frame = CGRectMake(0, -offset/8, self.animatedHeaderView.frame.size.width, self.animatedHeaderView.frame.size.height);
            }else if(self.animatedlevel==YHBaseHeaderAnimatedLevelFast){
                //快速
                self.animatedHeaderView.frame = CGRectMake(0, -offset/2, self.animatedHeaderView.frame.size.width, self.animatedHeaderView.frame.size.height);
            }else{
                //正常
                self.animatedHeaderView.frame = CGRectMake(0, -offset/4, self.animatedHeaderView.frame.size.width, self.animatedHeaderView.frame.size.height);
            }
            //进行渐隐动画处理
            CGFloat tmp = offset/2/_privteOriHeught;
            if (self.alphaAnimated) {
                self.animatedHeaderView.alpha = 1-(1-self.minAlpha)*tmp;
            }
            //进行模糊动画
            if (self.bluerAnimated) {
                _blurView.alpha = self.maxBluer*tmp;
            }
            //进行导航显示
            if (_naviBar) {
                _naviBar.backgroundColor = [_naviBar.backgroundColor colorWithAlphaComponent:tmp];
                if (_naviBar.shadowImage) {
                    [_naviBar setShadowImage:nil];
                }
                
            }
        }
        
       
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
