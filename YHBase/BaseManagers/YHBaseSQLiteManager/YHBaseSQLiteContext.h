//
//  YHBaseSQLiteContext.h
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/12.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//
/**
 *数据库操作对象 数据库上下文
 */

#import <Foundation/Foundation.h>
#import "YHBaseSQLError.h"
#import "YHBaseSQLTypeHeader.h"
#import <sqlite3.h>
@interface YHBaseSQLiteContext : NSObject
/**
 *操作的数据库名称
 */
__PROPERTY_NO_STRONG__(NSString *, name);
/**
 *内含sqlite3 对象
 */
__PROPERTY_NO_ASSIGN__READLY__(sqlite3 *, sqlite3_db);
/**
 * @brief 打开一个数据库 不存在则创建
 *
 * @param path 数据库路径
 *
 * @return 是否操作成功
 */
-(BOOL)openDataBaeWithName:(NSString *)path;
/**
 *  @brief 再数据库中创建一张表 如果已经存在 会返回错误信息
 *
 *  @param name 表的名称
 *
 *  @prarm dic 表中的键 其中字典中需传入 键名：类型  类型的宏定义在YHBaseSQLTypeHeader.h中
 *
 *  @param callBack 结果回调
 */
-(void)createTableWithName:(NSString *)name
            keysDictionary:(NSDictionary<NSString*,NSString*> *) dic
                  callBack:(void (^)(YHBaseSQLError * error))complete;

/**
 *  @brief 向表中添加一条数据
 *
 *  @param dataDic 添加数据的键值对
 *
 *  @param name 插入表的名称
 *
 *  @complete 回调
 */
-(void)insertData:(NSDictionary<NSString *,id>*)dataDic
        intoTable:(NSString *)name
         callBack:(void (^)(YHBaseSQLError * error))complete;
/**
 *  @brief 向表中添加一个键
 *
 *  @param kName 添加的键
 *
 *  @prarm type 类型
 *
 *  @prarm tableName 表名称
 *
 *  @prarm complete 结果回调
 */
-(void)addKey:(NSString *)kName
      keyType:(NSString *)type
    intoTable:(NSString *)tableName
     callBack:(void(^)(YHBaseSQLError *error))complete;
/**
 *  @brief 修改数据
 *
 *  @param dataDic 新的键值
 *
 *  @param wlStr 条件字符串 一般通过主键找到对应数据修改 可以为nil
 *
 *  @param complete 结果回调
 */
-(void)update:(NSDictionary<NSString*,id> *)dataDic
      inTable:(NSString *)tableName
  whileString:(NSString *)wlStr
     callBack:(void(^)(YHBaseSQLError * error))complete;
/**
 *  @brief 删除数据
 *
 *  @param tableName 表名
 *
 *  @param wlStr 条件字符串 一般通过主键找到对应数据删除 可以为nil 不传这个参数将删除所有数据
 *
 */
-(void)deleteDataFromTable:(NSString *)tableName
               whereString:(NSString *)wlStr
                  callBack:(void(^)(YHBaseSQLError * error))complete;
/**
 *  @brief 删除一张表
 *
 *  @param tableName 表名
 *
 */
-(void)dropTable:(NSString *)tableName
        callBack:(void(^)(YHBaseSQLError * error))complete;
/**
 *  @brief 查询数据
 *
 *  @param keys 要查询的键值 及其对应的数据类型 可以为nil则查询全部
 *
 *  @param tableName 表名
 *
 *  @param orderKey 进行排序的键值 可以为nil 则不排序
 *
 *  @param type 排序方式 在YHBaseSQLTypeHeader中有宏定义
 *
 *  @param wlstr 查询条件 同于查询单个数据
 *
 *  @param complete dataArray为查询到的数据 其内为字典
 *
 */
-(void)selectKeys:(NSArray<NSDictionary *> *)keys
        fromTable:(NSString*)tableName
          orderBy:(NSString *)orderKey
        orderType:(NSString *)type
         whileStr:(NSString *)wlstr
         callBack:(void(^)(NSArray<NSDictionary *> * dataArray,YHBaseSQLError * error))complete;
/**
 *  @brief 关闭数据库上下文操作
 *  调用此方法后 这个context对象将不再有效 如果再需要使用 需要YHBaseSQLiteManager中的类方法再次返回
 */
-(void)closeContext;
@end
