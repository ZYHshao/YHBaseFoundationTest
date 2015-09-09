//
//  YHBaseTableViewController.m
//  
//
//  Created by user on 15/9/9.
//
//

#import "YHBaseTableViewController.h"

@interface YHBaseTableViewController ()
{
    //私有的手势数组
    NSMutableArray * _clickHeadArray;
    //内部使用的数据源数组 对外界是透明的
    NSMutableArray * _privateDataArray;
}
@end

@implementation YHBaseTableViewController
-(void)dealloc{
    _cellFunc=nil;
    _refreshFunc=nil;
    _loadmoreFunc=nil;
    _selectedCellFunc=nil;
    for (UITapGestureRecognizer* tap in _clickHeadArray) {
        [tap.view removeGestureRecognizer:tap];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    //这个函数是默认不实现的 子类可以将设置部分再这个方法中重写
}
-(void)YHCreatView{
    _clickHeadArray = [[NSMutableArray alloc]init];
    _privateDataArray = [[NSMutableArray alloc]init];
    for (int i=0; i<_dataArray.count; i++) {
        NSMutableArray * subArray = [[NSMutableArray alloc]init];
        [subArray addObjectsFromArray:_dataArray[i]];
        [_privateDataArray addObject:subArray];
    }
    _tableView = [[YHBaseTableView alloc]initWithFrame:self.view.frame style:_tableViewStyle];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    if (_shouldRefresh) {
        [_tableView shouldRefresh:^{
            _refreshFunc();
        }];
    }
    if (_shouldLoadmore) {
        [_tableView shouldReload:^{
            _loadmoreFunc();
        }];
    }
    //为头视图加添手势
   //默认有效
        for (UIView * view in _headArray) {
            UITapGestureRecognizer * _clickHead = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openOrCloseSecetion:)];
            [view addGestureRecognizer:_clickHead];
            [_clickHeadArray addObject:_clickHead];
            if (!_isAutoOpenSection) {
                _clickHead.enabled=NO;
            }
        }
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _privateDataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_privateDataArray[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowsHight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [_headArray[section] frame].size.height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headArray[section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(_cellClass)];
    if (cell==nil) {
        if (_cellLoadStyle==YHBaseTableViewControllerCellLoadStyleFromNib) {
            cell = [[_cellClass alloc]init];
        }else{
            cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(_cellClass) owner:self options:nil]lastObject];
        }
    }
    
    _cellFunc([_privateDataArray[indexPath.section] objectAtIndex:indexPath.row],cell);
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedCellFunc(indexPath);
}

//关于刷新加载方面
-(void)startRefresh{
    [_tableView.header beginRefreshing];
}

-(void)endRefresh{
    [_tableView.header endRefreshing];
}
-(void)startLoadmore{
    [_tableView.footer beginRefreshing];
}
-(void)endLoadmore{
    [_tableView.footer endRefreshing];
}
-(void)loadAll{
    [_tableView ReloadEnd];
}

//手势处理

-(void)setIsAutoOpenSection:(BOOL)isAutoOpenSection{
    _isAutoOpenSection = isAutoOpenSection;
    if (_isAutoOpenSection) {
        for (UIGestureRecognizer * tap in _clickHeadArray) {
            tap.enabled=YES;
        }
    }else{
        for (UIGestureRecognizer * tap in _clickHeadArray) {
            tap.enabled=NO;
        }
    }
}

-(void)openOrCloseSecetion:(UITapGestureRecognizer *)pan{
    UIView * view = pan.view;
    //获取分区
    int section = 0;
    for (int i=0; i<_headArray.count; i++) {
        if (view == _headArray[i]) {
            section = i;
        }
    }
    if ([_privateDataArray[section] count]==0) {//闭合状态
        for (int i=0; i<[_dataArray[section] count]; i++) {
            [_privateDataArray[section] addObject:[_dataArray[section] objectAtIndex:i]];
        }
    }else{
        [_privateDataArray[section] removeAllObjects];
    }
    [_tableView beginUpdates];//动画块
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView endUpdates];
}
-(void)reloadData{
    [_privateDataArray removeAllObjects];
    for (int i=0; i<_dataArray.count; i++) {
        NSMutableArray * subArray = [[NSMutableArray alloc]init];
        [subArray addObjectsFromArray:_dataArray[i]];
        [_privateDataArray addObject:subArray];
    }
    //为头视图加添手势
    //默认有效
    for (UIView * view in _headArray) {
        if (_clickHeadArray.count<_headArray.count) {
            for (UITapGestureRecognizer* tap in _clickHeadArray) {
                [tap.view removeGestureRecognizer:tap];
            }
            [_clickHeadArray removeAllObjects];
            UITapGestureRecognizer * _clickHead = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openOrCloseSecetion:)];
            [view addGestureRecognizer:_clickHead];
            [_clickHeadArray addObject:_clickHead];
            if (!_isAutoOpenSection) {
                _clickHead.enabled=NO;
            }

        }
    }

    [_tableView reloadData];
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
