//
//  UIImageView+YHGifImage.h
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/22.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
/*
 *为UIImageView添加播放gif的支持
 */

#import <UIKit/UIKit.h>
typedef enum {
    YHGifImageViewDataTypeGif,//gif数据
    YHGifImageViewDataTypeNormal,//普通图片数据
    YHGifImageViewDataTypeWebImage//这种模式通过webView显示，加载慢，超流畅
}YHGifImageViewDataType;
@interface UIImageView (YHGifImage)
/**
 *  @brief 设置imageView的图片
 *
 *  @param imageUrl 图片素材的地址url
 *
 *  @param type 图片的类型
 *
 */
-(void)yh_setImage:(NSURL *)imageUrl type:(YHGifImageViewDataType)type;
/**
 *  @brief 根据本地文件名设置图片
 *
 *  @param imageName 图片名称必须写完整
 */
-(void)yh_setImageName:(NSString *)imageName type:(YHGifImageViewDataType)type;
@end
