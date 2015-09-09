//
//  YHBaseTableViewController.h
//  
//
//  Created by user on 15/9/9.
//
/**
 *这个tableViewController将大部分回调封装在内部
 *对于自定义性不强的表视图提供更加简单易用的设计方式
 *封装刷新与加载功能
 *封装分区展开与闭合的功能
 *这个类还非常不完善 后续许多地方可以优化
 */

#import "YHBaseViewController.h"
/**
 *加载cell的模型方法
 */
typedef void(^YHBaseTableViewControllerLoadCellFunc)(id model,UITableViewCell * cell);
/**
 *选中cell后执行的方法
 */
typedef void(^YHBaseTableViewControllerSelectedCell)(NSIndexPath *indexPath);
/**
 *下拉刷新的方法回调
 */
typedef void(^YHBaseTableViewControllerRefreshFunc)();
/**
 *上拉加载的方法回调
 */
typedef void(^YHBaseTableViewControllerLoadmoreFunc)();

typedef enum {
    YHBaseTableViewControllerCellLoadStyleFromNib,
    YHBaseTableViewControllerCellLoadStyleFromLine
}YHBaseTableViewControllerCellLoadStyle;
@interface YHBaseTableViewController : YHBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong,readonly)YHBaseTableView * tableView;
/**
 *这个数组的结构必须一致 是一个二维数组 第一维度中是分区  内层是每个分区的具体数据
 */
@property(nonatomic,strong)NSArray * dataArray;
/**
 *cell的类型 
 *注意这里cell的id 必须和类名相同 不然会影响复用
 */
@property(nonatomic,strong)Class cellClass;

@property(nonatomic,strong)YHBaseTableViewControllerLoadCellFunc cellFunc;
/**
 *行高
 */
@property(nonatomic,assign)CGFloat rowsHight;
/**
 *每个分区的头视图 没有 可以传nil,对象是UIView的子类
 */
@property(nonatomic,strong)NSArray * headArray;
/**
 *设置cell的加载模式  默认从代码加载，可以设置从nib文件加载
 */
@property(nonatomic,assign)YHBaseTableViewControllerCellLoadStyle cellLoadStyle;
/**
 *tableView的风格设置
 */
@property(nonatomic,assign)UITableViewStyle  tableViewStyle;
/**
 *是否开启下拉刷新
 */
@property(nonatomic,assign)BOOL shouldRefresh;
/**
 *是否开启上拉加载
 */
@property(nonatomic,assign)BOOL shouldLoadmore;
/**
 *下拉刷新与上拉加载的实现方法
 */
@property(nonatomic,strong)YHBaseTableViewControllerRefreshFunc refreshFunc;
@property(nonatomic,strong)YHBaseTableViewControllerLoadmoreFunc loadmoreFunc;
/**
 *选中cell执行的方法
 */
@property(nonatomic,strong)YHBaseTableViewControllerSelectedCell selectedCellFunc;
/**
 *开始与结束刷新动作
 */
-(void)startRefresh;
-(void)endRefresh;
/**
 *开始与结束加载动作
 */
-(void)startLoadmore;
-(void)endLoadmore;
/**
 *加载完全部数据
 */
-(void)loadAll;
/**
 *是否开启点击头视图 进行分区的收开
 */
@property(nonatomic,assign)BOOL isAutoOpenSection;
@end
