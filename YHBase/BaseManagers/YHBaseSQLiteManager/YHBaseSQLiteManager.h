//
//  YHBaseSQLiteManager.h
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/12.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//
/**
 * @brief 这个类提供简单的系统SQL的操作方法
 */
#import "YHBaseManager.h"
#import "YHBaseSQLiteContext.h"

@interface YHBaseSQLiteManager : YHBaseManager
/**
 *  @brief 打开一个数据库 如果不存在则会创建
 *
 *  @param name 数据库名称
 *
 *  @return 数据库操作对象 如果创建失败会返回nil
 *
 */
+(YHBaseSQLiteContext *)openSQLiteWithName:(NSString *)name;
/**
 *  @brief 获取数据库文件的大小 单位M
 *
 *  @param dataBase 数据库上下文对象
 *
 *  @return 数据库文件大小
 */
+(float)getSizeOfDataBase:(YHBaseSQLiteContext *)dataBase;
/**
 *  @brief 获取数据库文件的大小 单位M
 *
 *  @param dataBaseName 数据库名称
 *
 *  @return 数据库文件大小
 */
+(float)getSizeOfDataBaseName:(NSString *)dataBaseName;
/**
 *  @brief 获取全部数据库文件的大小 单位M
 *
 *  @return 数据库文件大小
 */
+(float)getAllSizeOfDataBase;
/**
 *  @brief 删除所有数据库
 *
 */
+(void)removeDataBase;
@end
