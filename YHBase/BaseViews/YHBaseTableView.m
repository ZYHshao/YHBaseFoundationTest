//
//  YHBaseTableView.m
//  
//
//  Created by user on 15/8/20.
//
//

#import "YHBaseTableView.h"

@implementation YHBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//重写这个方法来自定义文字
-(void)reloadView{
    _prepareRefreshText = @"下拉进行刷新";
    _alreadyRefreshText = @"正在为您刷新中~";
    _shouldRefreshText = @"松开即可刷新";
    
    _prepareReloadText = @"上拉开始加载";
    _alreadyReloadText = @"正在为您加载~";
    _shouldReloadText = @"放开即可加载";
}

-(void)shouldRefresh:(void (^)())block{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    self.header=header;
    [header setTitle:_prepareRefreshText forState:MJRefreshStateWillRefresh];
    [header setTitle:_shouldRefreshText forState:MJRefreshStatePulling];
    [header setTitle:_alreadyRefreshText forState:MJRefreshStateRefreshing];
    
}

-(void)shouldReload:(void (^)())block{
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
    self.footer=footer;
    [footer setTitle:_prepareReloadText forState:MJRefreshStateWillRefresh];
    [footer setTitle:_shouldReloadText forState:MJRefreshStatePulling];
    [footer setTitle:_alreadyReloadText forState:MJRefreshStateRefreshing];
}
//结束上拉加载
-(void)ReloadEnd{
    self.footer=nil;
}

@end
