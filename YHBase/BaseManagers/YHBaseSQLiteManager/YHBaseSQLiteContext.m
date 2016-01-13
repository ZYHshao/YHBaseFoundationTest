//
//  YHBaseSQLiteContext.m
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/12.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "YHBaseSQLiteContext.h"

@implementation YHBaseSQLiteContext
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(BOOL)openDataBaeWithName:(NSString *)path{
    if (sqlite3_open([path UTF8String], &_sqlite3_db)!=SQLITE_OK) {
        sqlite3_close(_sqlite3_db);
        _sqlite3_db=nil;
        return NO;
    }else{
        return YES;
    }
}


-(void)createTableWithName:(NSString *)name keysDictionary:(NSDictionary<NSString *,NSString *> *)dic callBack:(void (^)(YHBaseSQLError *))complete{
    NSMutableString * keys = [[NSMutableString alloc]init];
    for (int i=0; i<dic.allKeys.count; i++) {
        NSString * key = dic.allKeys[i];
        if (i<dic.allKeys.count-1) {
            [keys appendFormat:@"%@ %@,",key,[dic objectForKey:key]];
        }else{
            [keys appendFormat:@"%@ %@",key,[dic objectForKey:key]];
        }
    }
    NSString * sqlStr = [NSString stringWithFormat:@"create table %@(%@)",name,keys];
    [self runSQL:sqlStr callBack:^(YHBaseSQLError * error) {
        
        if (complete) {
            complete(error);
        }
        
    }];
}

-(void)insertData:(NSDictionary<NSString *,id> *)dataDic intoTable:(NSString *)name callBack:(void (^)(YHBaseSQLError *))complete{
    NSMutableString * keys = [[NSMutableString alloc]init];
    NSMutableString * values = [[NSMutableString alloc]init];
    for (int i=0; i<dataDic.allKeys.count; i++) {
        NSString * key = dataDic.allKeys[i];
        if (i<dataDic.count-1) {
            [keys appendFormat:@"%@,",key];
            [values appendFormat:@"\"%@\",",[dataDic objectForKey:key]];
        }else{
            [keys appendFormat:@"%@",key];
            [values appendFormat:@"\"%@\"",[dataDic objectForKey:key]];
        }
    }
    NSString * sqlStr = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",name,keys,values];
    [self runSQL:sqlStr callBack:^(YHBaseSQLError *error) {
        
        if (complete) {
            complete(error);
        }
        
    }];
}

-(void)addKey:(NSString *)kName keyType:(NSString *)type intoTable:(NSString *)tableName callBack:(void (^)(YHBaseSQLError *))complete{
    NSString * sqlStr = [NSString stringWithFormat:@"alter table %@ add %@ %@",tableName,kName,type];
    [self runSQL:sqlStr callBack:^(YHBaseSQLError *error) {
        if (complete) {
            complete(error);
        }
    }];
}

-(void)update:(NSDictionary<NSString *,id> *)dataDic inTable:(NSString *)tableName whileString:(NSString *)wlStr callBack:(void (^)(YHBaseSQLError *))complete{
    NSMutableString * sqlStr = [[NSMutableString alloc]init];
    [sqlStr appendFormat:@"update %@ set ",tableName];
    for (int i=0; i<dataDic.allKeys.count; i++) {
        NSString * key = dataDic.allKeys[i];
        if (i<dataDic.allKeys.count-1) {
            [sqlStr appendFormat:@"%@=\"%@\",",key,[dataDic objectForKey:key]];
        }else{
            [sqlStr appendFormat:@"%@=\"%@\"",key,[dataDic objectForKey:key]];
            if (wlStr!=nil) {
                [sqlStr appendFormat:@" where %@",wlStr];
            }
        }
    }
    [self runSQL:sqlStr callBack:^(YHBaseSQLError *error) {
        if (complete) {
            complete(error);
        }
    }];
}


-(void)deleteDataFromTable:(NSString *)tableName whereString:(NSString *)wlStr callBack:(void (^)(YHBaseSQLError *))complete{
    NSMutableString * sqlStr = [[NSMutableString alloc]init];
    [sqlStr appendFormat:@"delete from %@",tableName];
    if (wlStr!=nil) {
        [sqlStr appendFormat:@" where %@",wlStr];
    }
    [self runSQL:sqlStr callBack:^(YHBaseSQLError *error) {
        if (complete) {
            complete(error);
        }
    }];
}
-(void)dropTable:(NSString *)tableName callBack:(void (^)(YHBaseSQLError *))complete{
    NSString * sqlStr = [NSString stringWithFormat:@"drop table %@",tableName];
    [self runSQL:sqlStr callBack:^(YHBaseSQLError *error) {
        if (complete) {
            complete(error);
        }
    }];
}
-(void)selectKeys:(NSArray<NSDictionary *> *)keys fromTable:(NSString *)tableName orderBy:(NSString *)orderKey orderType:(NSString *)type whileStr:(NSString *)wlstr callBack:(void (^)(NSArray<NSDictionary *> *, YHBaseSQLError *))complete{
    NSMutableString * sqlStr = [[NSMutableString alloc]init];
    [sqlStr appendFormat:@"select"];
    if (keys==nil||keys.count==0) {
        [sqlStr appendFormat:@" * from %@",tableName];
    }else{
        for (int i=0; i<keys.count; i++) {
            if (i<keys.count-1) {
                [sqlStr appendFormat:@" %@,",keys[i].allKeys.firstObject];
            }else{
                [sqlStr appendFormat:@" %@ from %@",keys[i].allKeys.firstObject,tableName];
            }
            
        }
    }
    if (wlstr) {
        [sqlStr appendFormat:@" where %@",wlstr];
    }
    if (orderKey) {
        [sqlStr appendFormat:@" order by %@",orderKey];
    }
    if (type) {
        [sqlStr appendFormat:@" %@",type];
    }
    NSMutableArray * keysArr = [[NSMutableArray alloc]init];
    NSMutableArray * keysTypeArr = [[NSMutableArray alloc]init];
    if (keys==nil||keys.count==0) {
        NSArray<NSDictionary *> * tmpArr = [self getTheTableAllKeys:tableName];
        for (int i=0; i<tmpArr.count; i++) {
            NSString * key = tmpArr[i].allKeys.firstObject;
            [keysArr addObject:key];
            [keysTypeArr addObject:[tmpArr[i] objectForKey:key]];
        }
    }else{
        for (int i=0; i<keys.count; i++) {
            NSString * key = keys[i].allKeys.firstObject;
            [keysArr addObject:key];
            [keysTypeArr addObject:[keys[i] objectForKey:key]];
        }
    }
    
    [self runSelectSQL:sqlStr withKeys:keysArr withDataType:keysTypeArr callBack:^(NSArray<NSDictionary *> *dataArray, YHBaseSQLError *error) {
        if (complete) {
            complete(dataArray,error);
        }
    }];
   
}
-(void)closeContext{
    sqlite3_close(_sqlite3_db);
    _sqlite3_db = nil;
}

//内部方法 运行创建独立的非查询SQL语句
-(void)runSQL:(NSString *)sql callBack:(void(^)(YHBaseSQLError * error))complete{
    char * err;
    int code = sqlite3_exec(_sqlite3_db, [sql UTF8String], NULL, NULL, &err);
    if (code!=SQLITE_OK) {
        YHBaseSQLError * error = [[YHBaseSQLError alloc]init];
        error.errorInfo = [NSString stringWithCString:err encoding:NSUTF8StringEncoding];
        error.errorCode = code;
        complete(error);
    }else{
        complete(nil);
    }
}
//运行查询语句
-(void)runSelectSQL:(NSString *)sql withKeys:(NSArray *)keys withDataType:(NSArray *)dataType callBack:(void(^)(NSArray<NSDictionary *> * dataArray, YHBaseSQLError * error))complete{
    sqlite3_stmt *stmt =nil;
    int code = sqlite3_prepare_v2(_sqlite3_db, [sql UTF8String], -1, &stmt, NULL);
    if (code!=SQLITE_OK) {
        YHBaseSQLError * error = [[YHBaseSQLError alloc]init];
        error.errorInfo = @"查询失败";
        error.errorCode=code;
        complete(nil,error);
    }else{
        NSMutableArray * resultArray = [[NSMutableArray alloc]init];
        
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            //数据类型的分别解析
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            for (int i=0; i<dataType.count; i++) {
                NSString * type = dataType[i];
                if ([type isEqualToString:YHBASE_SQL_DATATYPE_BINARY]) {
                    int length = sqlite3_column_bytes(stmt, i);
                    const void *data = sqlite3_column_blob(stmt, i);
                    NSData * value = [NSData dataWithBytes:data length:length];
                    [dic  setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_BLOB]){
                    int length = sqlite3_column_bytes(stmt, i);
                    const void *data = sqlite3_column_blob(stmt, i);
                    NSData * value = [NSData dataWithBytes:data length:length];
                    [dic  setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_BOOLEAN]){
                    NSNumber * value = [NSNumber numberWithInt:sqlite3_column_int(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_CURRENCY]){
                    NSNumber * value = [NSNumber numberWithLong:sqlite3_column_int64(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_DATE]){
                    char * cString =(char*)sqlite3_column_text(stmt, i);
                    NSString * value = [NSString stringWithCString:cString?cString:"NULL" encoding:NSUTF8StringEncoding];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_DOUBLE]){
                    NSNumber * value = [NSNumber numberWithFloat:sqlite3_column_double(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_FLOAT]){
                    NSNumber * value = [NSNumber numberWithFloat:sqlite3_column_double(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_INTRGER]){
                    
                    NSNumber * value = [NSNumber numberWithInt:sqlite3_column_int(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_REAL]){
                    NSNumber * value = [NSNumber numberWithDouble:sqlite3_column_int(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_SMALLINT]){
                    NSNumber * value = [NSNumber numberWithShort:sqlite3_column_int(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_TEXT]){
                    char * cString =(char*)sqlite3_column_text(stmt, i);
                    NSString * value = [NSString stringWithCString:cString?cString:"NULL" encoding:NSUTF8StringEncoding];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_TIME]){
                    char * cString =(char*)sqlite3_column_text(stmt, i);
                    NSString * value = [NSString stringWithCString:cString?cString:"NULL" encoding:NSUTF8StringEncoding];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_TIMESTAMP]){
                    NSNumber * value = [NSNumber numberWithLongLong:sqlite3_column_int64(stmt, i)];
                    [dic setObject:value forKey:keys[i]];
                }else if([type isEqualToString:YHBASE_SQL_DATATYPE_VARCHAR]){
                    char * cString =(char*)sqlite3_column_text(stmt, i);
                    NSString * value = [NSString stringWithCString:cString?cString:"NULL" encoding:NSUTF8StringEncoding];
                    [dic setObject:value forKey:keys[i]];
                }
               
            }
             [resultArray addObject:dic];
        }
         sqlite3_finalize(stmt);
        stmt=nil;
        complete(resultArray,nil);
    }
}
//获取表中所有字段名和类型
-(NSArray<NSDictionary *> *)getTheTableAllKeys:(NSString *)tableName{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSString * getColumn = [NSString stringWithFormat:@"PRAGMA table_info(%@)",tableName];
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(_sqlite3_db, [getColumn UTF8String], -1, &statement, nil);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        char *nameData = (char *)sqlite3_column_text(statement, 1);
        NSString *columnName = [[NSString alloc] initWithUTF8String:nameData];
        char *typeData = (char *)sqlite3_column_text(statement, 2);
        NSString *columntype = [NSString stringWithCString:typeData encoding:NSUTF8StringEncoding];
        NSDictionary * dic = @{columnName:columntype};
        [array addObject:dic];
    }
     sqlite3_finalize(statement);
    statement=nil;
    return array;
}

@end
