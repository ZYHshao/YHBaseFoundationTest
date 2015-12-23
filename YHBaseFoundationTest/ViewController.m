//
//  ViewController.m
//  YHBaseFoundationTest
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<YHBaseLinkingLabelProtocol>
{
    YHBaseLinkingLabel * label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    label = [[YHBaseLinkingLabel alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        YHBaseLinkingLabelModel * model = [[YHBaseLinkingLabelModel alloc]init];
        if (!(i%2)) {
            model.text =[NSString stringWithFormat:@"第%d个标签",i];
            model.linking = [NSString stringWithFormat:@"第%d个标签",i];
        }else{
            model.text = @",";
        }
        [array addObject:model];
    }
    label.textColor = [UIColor blackColor];
    label.linkColor = [UIColor purpleColor];
    label.fontSize = 15;
    label.linkingFontSize = 5;
    label.isShowUnderLine=YES;
    label.delegate=self;
    label.textArray = array;
    [self.view addSubview:label];
   
}
-(void)YHBaseLinkingLabelClickLinking:(YHBaseLinkingLabelModel *)model{
    NSLog(@"%@",model.linking);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
