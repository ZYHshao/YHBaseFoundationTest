//
//  YHBaseCecheHeader.h
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//缓存路径的头文件和枚举

#ifndef StudyApp_YHBaseCecheHeader_h
#define StudyApp_YHBaseCecheHeader_h
/*
 *缓存路径的枚举
 */
typedef enum {
    YHBaseCecheMain=1,
    YHBaseCecheImage,
    YHBaseCecheFile,
    YHBaseCecheVedio,
    YHBaseCecheAudio,
    //归档的目录，专门用于存数据模型
    YHBaseArchiver,
    //专门用于存放数据库
    YHBaseDataBase
}YHBaseCechePath;

#define YH_BASE_CECHE_PATH_MAIN @"/Library/Caches/MyCache/Main"
#define YH_BASE_CECHE_PATH_IMAGE @"/Library/Caches/MyCache/Image"
#define YH_BASE_CECHE_PATH_FILE @"/Library/Caches/MyCache/File"
#define YH_BASE_CECHE_PATH_VEDIO @"/Library/Caches/MyCache/Vedio"
#define YH_BASE_CECHE_PATH_AUDIO @"/Library/Caches/MyCache/Audio"
#define YH_BASE_CECHE_PATH_Archiver @"/Library/Caches/Archiver"
#define YH_BASE_CECHE_PATH_DATABASE @""
#endif
