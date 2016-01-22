//
//  UIImageView+YHGifImage.m
//  YHBaseFoundationTest
//
//  Created by jaki on 16/1/22.
//  Copyright © 2016年 jaki.zhang. All rights reserved.
//

#import "UIImageView+YHGifImage.h"
#import <ImageIO/ImageIO.h>
@implementation UIImageView (YHGifImage)
-(void)yh_setImage:(NSURL *)imageUrl type:(YHGifImageViewDataType)type{
    if (type==YHGifImageViewDataTypeGif) {
        __BLOCK__WEAK__SELF__(__self);
        [self getGifImageWithUrk:imageUrl returnData:^(NSArray<UIImage *> *imageArray, NSArray<NSNumber *> *timeArray, CGFloat totalTime, NSArray<NSNumber *> *widths, NSArray<NSNumber *> *heights) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
            NSMutableArray * times = [[NSMutableArray alloc]init];
            float currentTime = 0;
            for (int i=0; i<imageArray.count; i++) {
                [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
                currentTime+=[timeArray[i] floatValue];
            }
            [animation setKeyTimes:times];
            [animation setValues:imageArray];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            animation.repeatCount= MAXFLOAT;
            animation.duration = totalTime;
            [[(UIImageView *)__self layer]addAnimation:animation forKey:@"gifAnimation"];
        }];

    }else if (type==YHGifImageViewDataTypeNormal){
        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    }else if (type==YHGifImageViewDataTypeWebImage){
        NSData *gifData = [NSData dataWithContentsOfURL:imageUrl];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        webView.scrollView.bounces=NO;
        webView.backgroundColor = [UIColor clearColor];
        webView.scalesPageToFit = YES;
        [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        [self addSubview:webView];
    }
}

-(void)yh_setImageName:(NSString *)imageName type:(YHGifImageViewDataType)type{
     NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    [self yh_setImage:url type:type];
}

/*=====================================内部方法======================*/
-(void)getGifImageWithUrk:(NSURL *)url
               returnData:(void(^)(NSArray<UIImage *> * imageArray,
                                NSArray<NSNumber *>*timeArray,
                                CGFloat totalTime,
                                NSArray<NSNumber *>* widths,
                                NSArray<NSNumber *>* heights))dataBlock{
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    size_t count = CGImageSourceGetCount(source);
    float allTime=0;
    //遍历取图片
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    NSMutableArray * timeArray = [[NSMutableArray alloc]init];
    NSMutableArray * widthArray = [[NSMutableArray alloc]init];
    NSMutableArray * heightArray = [[NSMutableArray alloc]init];
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        NSDictionary * info = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        CGFloat width = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
        allTime+=time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
    }
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);
}

@end
