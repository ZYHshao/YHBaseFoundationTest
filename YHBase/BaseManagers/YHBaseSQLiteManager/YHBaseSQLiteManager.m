//
//  YHBaseSQLiteManager.m
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/12.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseSQLiteManager.h"

@implementation YHBaseSQLiteManager
+(instancetype)sharedTheSingletion{
    static YHBaseSQLiteManager * sharedModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedModel = [[YHBaseSQLiteManager alloc] init];
    });
    return sharedModel;
}

+(YHBaseSQLiteContext *)openSQLiteWithName:(NSString *)name{
    
    NSString * path =  [[YHBaseCecheCenter sharedTheSingletion]getDataBaseFilePath];
    YHBaseSQLiteContext * context = [[YHBaseSQLiteContext alloc]init];
    context.name = name;
    BOOL success = [context openDataBaeWithName:[NSString stringWithFormat:@"%@/%@",path,name]];
    if (success) {
        return context;
    }else{
        return nil;
    }
}
+(float)getSizeOfDataBase:(YHBaseSQLiteContext *)dataBase{
    return [[YHBaseCecheCenter sharedTheSingletion]getSizeFromDataBaseName:dataBase.name];
}
+(float)getSizeOfDataBaseName:(NSString *)dataBaseName{
    return [[YHBaseCecheCenter sharedTheSingletion]getSizeFromDataBaseName:dataBaseName];
}
+(float)getAllSizeOfDataBase{
    return [[YHBaseCecheCenter sharedTheSingletion]getAllDataBaseSize];
}
+(void)removeDataBase{
    return [[YHBaseCecheCenter sharedTheSingletion]removeCacheFromPath:YHBaseDataBase];
}
@end
