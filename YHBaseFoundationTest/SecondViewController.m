//
//  SecondViewController.m
//  YHBaseFoundationTest
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //测试动画头图
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    imageV.image = [UIImage imageNamed:@"image"];
//    self.animatedHeaderView = imageV;
    //测试默认头图
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    header.backgroundColor = [UIColor redColor];
    self.minAlpha  = 0;
//    self.alphaAnimated = YES;
    self.bluerAnimated = YES;
    self.tableHeaderView = header;
    self.animatedlevel = YHBaseHeaderAnimatedLevelNormal;
    [self reloadAnimatedView];
    UIButton  *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn addTarget:self action:@selector(ta) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)ta{
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
}

@end
