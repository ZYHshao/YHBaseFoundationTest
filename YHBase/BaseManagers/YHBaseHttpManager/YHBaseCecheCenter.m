//
//  YHBaseCecheCenter.m
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseCecheCenter.h"

@implementation YHBaseCecheCenter
+(instancetype)sharedTheSingletion{
    static YHBaseCecheCenter * manager = nil;
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
        //缓存地址的拼接
        [self creatCachePath];
    }
    return self;
}
-(void)creatCachePath{
    _mainCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_MAIN];
    _imageCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_IMAGE];
    _fileCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_FILE];
    _audioCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_AUDIO];
    _videoCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_VEDIO];
}


-(void)writeCecheFile:(NSData *)data
           withFileID:(NSString *)fileID
               toPath:(YHBaseCechePath)path{
    NSString * cechePath = [self getCechePath:path];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //判断目录是否存在
    if (![fileManager fileExistsAtPath:cechePath]) {
        //创建目录
        [fileManager createDirectoryAtPath:cechePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //拼接文件路径
    NSMutableString * tempStr = [[NSMutableString alloc]init];
    for (int i=0; i<fileID.length; i++) {
        if (([fileID characterAtIndex:i]<='9'&&[fileID characterAtIndex:i]>='0')||([fileID characterAtIndex:i]<='z'&&[fileID characterAtIndex:i]>='a')||([fileID characterAtIndex:i]<='Z'&&[fileID characterAtIndex:i]>='A')) {
            [tempStr appendFormat:@"%c",[fileID characterAtIndex:i]];
        }
    }
    NSString * writePath = [cechePath stringByAppendingFormat:@"/%@",tempStr];
    [data writeToFile:writePath atomically:YES];
//    NSLog(@"写缓存");
}

-(NSData *)readCecheFile:(NSString *)fileID fromPath:(YHBaseCechePath)path{
    NSString * cechePath = [self getCechePath:path];
    NSMutableString * tempStr = [[NSMutableString alloc]init];
    for (int i=0; i<fileID.length; i++) {
        if (([fileID characterAtIndex:i]<='9'&&[fileID characterAtIndex:i]>='0')||([fileID characterAtIndex:i]<='z'&&[fileID characterAtIndex:i]>='a')||([fileID characterAtIndex:i]<='Z'&&[fileID characterAtIndex:i]>='A')) {
            [tempStr appendFormat:@"%c",[fileID characterAtIndex:i]];
        }
    }
    NSString * readPath = [cechePath stringByAppendingFormat:@"/%@",tempStr];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //判断文件是否
    if (![fileManager fileExistsAtPath:readPath]) {
       
        return nil;
    }else{
        NSData *data = [NSData dataWithContentsOfFile:readPath];
        return data;
    }
   

}

-(NSString *)getCechePath:(YHBaseCechePath)path{
    switch (path) {
            //从1开始
        case 1:
        {
            return _mainCechePath;
        }
            break;
        case 2:
        {
            return _imageCechePath;
        }
            break;
        case 3:
        {
            return _fileCechePath;
        }
            break;
        case 4:
        {
            return _videoCechePath;
        }
            break;
        case 5:
        {
            return _audioCechePath;
        }
            break;
        default:
            return _mainCechePath;
            break;
    }

}

-(float)getAllCache{
    return ([self getSizeFromCachePath:YHBaseCecheMain]+[self getSizeFromCachePath:YHBaseCecheVedio]+[self getSizeFromCachePath:YHBaseCecheFile]+[self getSizeFromCachePath:YHBaseCecheVedio]+[self getSizeFromCachePath:YHBaseCecheImage]);
}

-(float)getSizeFromCachePath:(YHBaseCechePath)path{
    NSString * cachePth = [NSString stringWithFormat:@"/%@",[self getCechePath:path]];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cachePth]){
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePth] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [cachePth stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
    
}
//获取单个文件大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}




-(void)removeCacheFromPath:(YHBaseCechePath)path{
     NSString * cachePth = [NSString stringWithFormat:@"/%@",[self getCechePath:path]];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cachePth]){
        return;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePth] objectEnumerator];
    NSString* fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [cachePth stringByAppendingPathComponent:fileName];
       [manager removeItemAtPath:fileAbsolutePath error:NULL];
    }
}

-(void)removeAllCache{
    [self removeCacheFromPath:YHBaseCecheAudio];
    [self removeCacheFromPath:YHBaseCecheFile];
    [self removeCacheFromPath:YHBaseCecheImage];
    [self removeCacheFromPath:YHBaseCecheMain];
    [self removeCacheFromPath:YHBaseCecheVedio];
}

@end
