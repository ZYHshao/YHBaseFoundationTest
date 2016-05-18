//
//  ViewController.m
//  YHBaseFoundationTest
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestModel * model = [[TestModel alloc]init];
    model.one = @"22";
    model.two = @"33";
    [[YHBaseNetManager sharedTheSingletion]netForRequestName:@"weather" withParam:model forDataModel:model completion:^(BOOL success, YHBaseError *error) {
        
    }];
    
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
