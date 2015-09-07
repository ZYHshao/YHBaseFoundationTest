//
//  YHBaseAVPlayer.h
//  
//
//  Created by user on 15/8/28.
//
//封装的一个播放音频的类，支持播放流音频，边下边播，进行缓存

#import <Foundation/Foundation.h>
//播放状态的枚举
typedef enum {
    YHBaseAVPlayerStatePlaying,
    YHBaseAVPlayerStateStop,
    YHBaseAVPlayerStateLoading,
    YHBaseAVPlayerStatePause
}YHBaseAVPlayerState;

@interface YHBaseAVPlayer : NSObject<YHSingletonProcotol>

@property(nonatomic,readonly,assign)YHBaseAVPlayerState state;



/**
 *播放前需要调用这个函数 设置一个url
 */
-(void)preparePlayWithUrl:(NSString *)url;
/**
 *开始播放
 */
-(void)play;
/**
 *停止播放
 */
-(void)stop;
/**
 *暂停播放
 */
-(void)pause;
@end
