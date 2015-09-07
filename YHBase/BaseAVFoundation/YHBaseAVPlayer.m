//
//  YHBaseAVPlayer.m
//  
//
//  Created by user on 15/8/28.
//
//

#import "YHBaseAVPlayer.h"
#import "AudioStreamer.h"
#import <AVFoundation/AVFoundation.h>
#import "YHBaseCecheCenter.h"
@interface YHBaseAVPlayer()
{
    //播放流媒体的引擎
    AudioStreamer * _streamer;
    //播放缓存文件的引擎
    AVAudioPlayer * _cechePlayer;
    //是否播放流媒体音频
    BOOL _isStreamer;
}
@end

@implementation YHBaseAVPlayer
+(instancetype)sharedTheSingletion{
    static YHBaseAVPlayer * player = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        player = [[[self class] alloc] init];
    });
    return player;
}

//初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        _state=YHBaseAVPlayerStateStop;
    }
    return self;
}

-(void)preparePlayWithUrl:(NSString *)url{
    //判断本地文件是否存在
    NSData * avData = [[YHBaseCecheCenter sharedTheSingletion]readCecheFile:url fromPath:YHBaseCecheAudio];
    if (avData) {
        _isStreamer=NO;
        [self deallocCechePlayer];
        _cechePlayer = [[AVAudioPlayer alloc]initWithData:avData error:nil];
        [_cechePlayer prepareToPlay];
        NSLog(@"本地音频");
    }else{
        _isStreamer=YES;
        NSString *escapedValue =
        ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                               nil,
                                                                               (CFStringRef)url,
                                                                        NULL,
                                                                               NULL,
                                                                               kCFStringEncodingUTF8)) ;
        ;
        NSURL *newUrl = [NSURL URLWithString:escapedValue];
        [self deallocStreamer];
        _streamer = [[AudioStreamer alloc] initWithURL:newUrl];
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(playbackStateChanged:)
         name:ASStatusChangedNotification
         object:_streamer];
        //在分线程中进行数据的下载
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData * downData = [NSData dataWithContentsOfURL:newUrl];
            //进行缓存
            [[YHBaseCecheCenter sharedTheSingletion]writeCecheFile:downData withFileID:url toPath:YHBaseCecheAudio];
            NSLog(@"缓存完成");
        });
        NSLog(@"远程音频");
    }
}
//重置流媒体引擎
-(void)deallocStreamer{
    if (_streamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:_streamer];
        
        [_streamer stop];
        _streamer = nil;
    }
}


-(void)deallocCechePlayer{
    if (_cechePlayer) {
        [_cechePlayer stop];
        _cechePlayer = nil;
    }
}
#pragma mark - 播放器控制
-(void)play{
    if (_isStreamer) {
        [_streamer start];
    }else{
        _state = YHBaseAVPlayerStatePlaying;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStatePlaying]};
        NSNotification* notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        [_cechePlayer play];
    }
}
-(void)stop{
    if (_isStreamer) {
        [_streamer stop];
    }else{
        //发送通知
        _state = YHBaseAVPlayerStateStop;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStateStop]};
        NSNotification* notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        [_cechePlayer stop];
    }
}
-(void)pause{
    if (_isStreamer) {
        [_streamer pause];
    }else{
        _state = YHBaseAVPlayerStatePause;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStatePause]};
        NSNotification* notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        [_cechePlayer pause];
    }
}
- (void)playbackStateChanged:(NSNotification *)aNotification
{
    //发送通知
    NSNotification * notice;
    if ([_streamer isWaiting])
    {
        _state = YHBaseAVPlayerStateLoading;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStateLoading]};
        notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
    }
    else if ([_streamer isPlaying])
    {
        _state = YHBaseAVPlayerStatePlaying;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStatePlaying]};
        notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
    }
    else if ([_streamer isPaused])
    {
        _state = YHBaseAVPlayerStatePause;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStatePause]};
        notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
        
    }
    else if ([_streamer isIdle])
    {
        [self deallocStreamer];
        _state = YHBaseAVPlayerStateStop;
        NSDictionary * info = @{@"state":[NSString stringWithFormat:@"%d",YHBaseAVPlayerStateStop]};
        notice = [[NSNotification alloc]initWithName:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil userInfo:info];
    }
    [[NSNotificationCenter defaultCenter]postNotification:notice];

}

@end
