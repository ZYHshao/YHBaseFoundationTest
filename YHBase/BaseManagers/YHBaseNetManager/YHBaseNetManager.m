//
//  YHBaseNetManager.m
//  YHBaseFoundationTest
//
//  Created by vip on 16/5/18.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseNetManager.h"

@implementation YHBaseNetManager
{
    @private NSArray * _urlArray;
}
+(instancetype)sharedTheSingletion{
    static YHBaseNetManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
//初始化时将plist文件中所有的请求模型读取出
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"YHBaseNetPlist" ofType:@"plist"];
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * tmpArr = [NSMutableArray array];
        for (NSDictionary * dic in array) {
            YHBaseNetModel * model = [[YHBaseNetModel alloc]init];
            [model creatModelWithDic:dic];
            [tmpArr addObject:model];
        }
        _urlArray = [tmpArr copy];
    }
    return self;
}
-(void)netForRequestName:(NSString *)name withParam:(YHBaseModel *)param forDataModel:(YHBaseModel *)dataModel completion:(void (^)(BOOL, YHBaseError *))completion{
    //遍历出请求对象
    YHBaseNetModel * model = nil;
    for (YHBaseNetModel * md in _urlArray) {
        if ([md.name isEqualToString:name]) {
            model  = [[YHBaseNetModel alloc]init];
            model.name = md.name;
            model.url = md.url;
            model.method=md.method;
            break;
        }
    }
    if (model==nil) {
        YHBaseError * error = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
        error.msg = [NSString stringWithFormat:@"没有在plist文件中配置此请求:%@",name];
        completion(NO,error);
        return;
    }
    //获取请求方法
    NSString * method = model.method;
    if ([method isEqualToString:@"GET"]) {
        NSMutableString * urlStr = [[NSMutableString alloc]initWithString:model.url];
        if (model.url==nil) {
            YHBaseError * error = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
            error.msg = [NSString stringWithFormat:@"请求的url不能为空:%@",name];
            completion(NO,error);
            return;
        }
        //获取请求参数字典
        if (param!=nil) {
            NSDictionary * paramDic = [param modelMappingToDictionary];
            //向url中拼接参数
            //标记是否是第一个参数
            BOOL tip = YES;
            for (NSString * key in paramDic.allKeys) {
                if (paramDic[key]!=nil) {
                    if (tip) {
                        [urlStr appendString:@"?"];
                        [urlStr appendFormat:@"%@=%@",key,paramDic[key]];
                        tip = NO;
                    }else{
                        [urlStr appendString:@"&"];
                        [urlStr appendFormat:@"%@=%@",key,paramDic[key]];
                    }
                    
                }
            }
        }
        //进行请求
        YHBaseHttpRequestObject * obj = [[YHBaseHttpRequestObject alloc]init];
        obj.urlString = urlStr;
        obj.requestIdentity = name;
        [[YHBaseHttpManager sharedTheSingletion] YHBaseHttpRequestGETFromRequestObject:obj requestSuccess:^(NSData *data) {
            [dataModel creatModelWithData:data];
            completion(YES,nil);
        } requestField:^(YHBaseError *error) {
            completion(NO,error);
        } isCeche:NO toCechePath:YHBaseCecheMain];
    }else if([method isEqualToString:@"POST"]){
        NSMutableString * urlStr = [[NSMutableString alloc]initWithString:model.url];
        if (model.url==nil) {
            YHBaseError * error = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
            error.msg = [NSString stringWithFormat:@"请求的url不能为空:%@",name];
            completion(NO,error);
            return;
        }
        YHBaseHttpRequestObject * obj = [[YHBaseHttpRequestObject alloc]init];
        obj.urlString = urlStr;
        obj.requestIdentity = name;
        obj.pramaDic = [param modelMappingToDictionary];
        [[YHBaseHttpManager sharedTheSingletion]YHBaseHttpRequestPOSTFromRequestObject:obj withParamDictionary:obj.pramaDic requestSuccess:^(NSData *data) {
            [dataModel creatModelWithData:data];
            completion(YES,nil);
        } requestField:^(YHBaseError *error) {
            completion(NO,error);
        } isCeche:NO toCechePath:YHBaseCecheMain];
    }else{
        YHBaseError * error = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
        error.msg = [NSString stringWithFormat:@"不支持的请求方法:%@：%@",name,model.method];
        completion(NO,error);
        return;
    }
}

@end
