//
//  ViewController.m
//  YHBaseFoundationTest
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    YHBaseCircleView * view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    view = [[YHBaseCircleView alloc]initWithFrame:CGRectMake(160, 100, 100, 100)];
//    view.minLineColor = [UIColor blueColor];
//    view.midLineColor = [UIColor purpleColor];
//    view.maxLineColor = [UIColor cyanColor];
    view.progress = 0.5;
    view.lineWidth = 8;
    view.textColor = [UIColor blueColor];
    view.tintColor = [UIColor purpleColor];
    [self.view addSubview:view];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [view setProgress:arc4random()%100/100.0 animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
