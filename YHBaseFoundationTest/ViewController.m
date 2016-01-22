//
//  ViewController.m
//  YHBaseFoundationTest
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 320, 200)];
    [imageView yh_setImageName:@"20051103121420947.gif" type:YHGifImageViewDataTypeGif];
    [self.view addSubview:imageView];
   
   
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
