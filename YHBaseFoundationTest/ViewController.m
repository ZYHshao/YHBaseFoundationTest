//
//  ViewController.m
//  YHBaseFoundationTest
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<YHBaseCalendarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YHBaseCalendarView * view = [[YHBaseCalendarView alloc]initWithFrame:CGRectMake(0, 64, 320, 400)];
    view.currentDate = [NSDate date];
    view.backgroundColor = [UIColor redColor];
    view.delegate=self;
    [self.view addSubview:view];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.navigationController pushViewController:[[SecondViewController alloc]init] animated:YES];
////    [self presentViewController:[[SecondViewController alloc]init] animated:YES completion:nil];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
