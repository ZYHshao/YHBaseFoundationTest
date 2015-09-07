//
//  YHBaseHttpManager.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHBaseHttpManager.h"

@implementation YHBaseHttpManager
+(instancetype)sharedTheSingletion{
    static YHBaseHttpManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       self.requestArray = [[NSMutableArray alloc]init];

    }
    return self;
}

-(void)YHBaseHttpRequestGETFromRequestObject:(YHBaseHttpRequestObject *)obj requestSuccess:(void (^)(NSData * data))successBlock requestField:(void (^)(YHBaseError * error))fieldBlock isCeche:(BOOL)ceche toCechePath:(YHBaseCechePath)path{
    if (ceche) {
        //先读缓存
        NSData * da = [[YHBaseCecheCenter sharedTheSingletion] readCecheFile:obj.requestIdentity fromPath:path];
        if (da==nil) {
            //进行网络请求
            [self YHBaseHttpRequestGETFromRequestObject:obj requestSuccess:^(NSData * data) {
                successBlock(data);
                //进行写缓存
                [[YHBaseCecheCenter sharedTheSingletion]writeCecheFile:data withFileID:obj.requestIdentity toPath:path];
            } requestField:^(YHBaseError * error) {
                fieldBlock(error);
            }];
        }else{
            successBlock(da);
        }
    }else{
        [self YHBaseHttpRequestGETFromRequestObject:obj requestSuccess:^(NSData * data) {
            successBlock(data);
            [[YHBaseCecheCenter sharedTheSingletion]writeCecheFile:data withFileID:obj.requestIdentity toPath:path];
        } requestField:^(YHBaseError *error) {
            fieldBlock(error);
        }];

    }
}

-(void)YHBaseHttpRequestPOSTFromRequestObject:(YHBaseHttpRequestObject *)obj withParamDictionary:(NSDictionary *)paramDic requestSuccess:(void (^)(NSData *))successBlock requestField:(void (^)(YHBaseError *))fieldBlock isCeche:(BOOL)ceche toCechePath:(YHBaseCechePath)path{
    if (ceche) {
        //先读缓存
        NSData * da = [[YHBaseCecheCenter sharedTheSingletion] readCecheFile:obj.requestIdentity fromPath:path];
        if (da==nil) {
            //进行网络请求
            [self YHBaseHttpRequestPOSTFromRequestObject:obj withParamDictionary:paramDic requestSuccess:^(NSData *data) {
                successBlock(data);
                [[YHBaseCecheCenter sharedTheSingletion]writeCecheFile:data withFileID:obj.requestIdentity toPath:path];
            } requestField:^(YHBaseError * error) {
                fieldBlock(error);
            }];
            
        }else{
            successBlock(da);
        }
    }else{
        
        [self YHBaseHttpRequestPOSTFromRequestObject:obj withParamDictionary:paramDic requestSuccess:^(NSData *data) {
            successBlock(data);
            [[YHBaseCecheCenter sharedTheSingletion]writeCecheFile:data withFileID:obj.requestIdentity toPath:path];
        } requestField:^(YHBaseError * error) {
            fieldBlock(error);
        }];
    }

}



//=======================private func========================//
-(void)YHBaseHttpRequestGETFromRequestObject:(YHBaseHttpRequestObject *)obj requestSuccess:(void (^)(NSData * data))successBlock requestField:(void (^)(YHBaseError * error))fieldBlock{
    //判断此请求是否正在进行
    for (YHBaseHttpRequestObject * request in _requestArray) {
        if ([obj.requestIdentity isEqualToString:request.requestIdentity]) {
            //取消请求
            return;
        }
    }
    //将请求加入数组
    [_requestArray addObject:obj];
    //进行请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:obj.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //字符串转data
        NSData * da = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        successBlock(da);
        //从数组中删除对象
        [_requestArray removeObject:obj];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        YHBaseError * er = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
        //发送通知给异常处理中心
        [YHBaseErrorCenter sharedTheSingletion];
        NSNotification * notice = [NSNotification notificationWithName:YHBASE_ERROR_CENTER_NOTICATION object:nil userInfo:@{@"error":er}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        fieldBlock(er);
        
        [_requestArray removeObject:obj];
    }];
}

-(void)YHBaseHttpRequestPOSTFromRequestObject:(YHBaseHttpRequestObject *)obj withParamDictionary:(NSDictionary *)paramDic requestSuccess:(void (^)(NSData * data))successBlock requestField:(void (^)(YHBaseError * error))fieldBlock{
    //判断此请求是否正在进行
    for (YHBaseHttpRequestObject * request in _requestArray) {
        if ([obj.requestIdentity isEqualToString:request.requestIdentity]) {
            //取消请求
            return;
        }
    }
    //将请求加入数组
    [_requestArray addObject:obj];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   [manager POST:obj.urlString parameters:obj.pramaDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSData * da = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
       [_requestArray removeObject:obj];
       successBlock(da);
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       YHBaseError * er = [[YHBaseError alloc]initWithType:YHBaseErrorRequestLocal];
       //发送通知给异常处理中心
       [YHBaseErrorCenter sharedTheSingletion];
       NSNotification * notice = [NSNotification notificationWithName:YHBASE_ERROR_CENTER_NOTICATION object:nil userInfo:@{@"error":er}];
       [[NSNotificationCenter defaultCenter]postNotification:notice];
        [_requestArray removeObject:obj];
       fieldBlock(er);
       
      
   }];
}




@end
