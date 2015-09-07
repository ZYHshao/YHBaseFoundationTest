//
//  YHBaseNavigationController.m
//  
//
//  Created by user on 15/8/18.
//
//导航的基类

#import "YHBaseNavigationController.h"

@interface YHBaseNavigationController ()

@end

@implementation YHBaseNavigationController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加监听主题更换的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(useYHTopicToCreatViewWithModel) name:YH_BASE_TOPIC_CHANGE_TOPIC_NOTICATION object:nil];
    [self YHCreatView];
    //加载主题
    [self useYHTopicToCreatViewWithModel];
}
//子类实现如下方法
-(void)YHCreatView{
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)useYHTopicToCreatViewWithModel{
    
}
-(void)YHCreatDate{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
