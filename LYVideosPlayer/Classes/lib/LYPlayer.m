//
//  LYPlayer.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYPlayer.h"
#import <AVKit/AVKit.h>
@interface LYPlayer ()

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) AVPlayerItem *playItem;

@property (nonatomic,strong) AVPlayerLayer *playLayer;

@property (nonatomic,assign,readwrite) BOOL  isPlaying;

@property (nonatomic,assign) CGFloat videoTime;


@end

@implementation LYPlayer

- (instancetype)initWithVideoUrl:(NSString *)url VideoView:(UIView *)videoView
{
    self = [super init];
    if (self) {
        self.playItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
        self.player = [AVPlayer playerWithPlayerItem:self.playItem];
        self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playLayer.frame = CGRectMake(100, 100, 199, 399);
        [videoView.layer addSublayer:self.playLayer];
        [self addobserverWithPlayer];
    }
    return self;
}

-(void)addobserverWithPlayer{
    [self.playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

//切换视频
- (void)updatePlayerWithURL:(NSURL *)url {
    self.playItem = [[AVPlayerItem alloc]initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:self.playItem];
    
}


#pragma mark ==处理KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem * item = (AVPlayerItem *)object;
    //监听视频的状态
    if ([keyPath isEqualToString:@"status"]) {
        
        AVPlayerItemStatus  newStatus = [[change objectForKey:@"new"] integerValue];
        switch (newStatus) {
            case AVPlayerItemStatusReadyToPlay:
            {
                self.videoTime = CMTimeGetSeconds(item.duration);
                [self resumePlay];
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                
            }
                
                break;
            case AVPlayerItemStatusUnknown:
            {
                
            }
                
                break;
                
            default:
                break;
        }
        
    }
}

#pragma mark == playerAction

/**
 停止播放并移除播放视图
 */
- (void)removeVideo{
    
}

/**
 暂停播放
 */
- (void)pausePlay{
    [self.player pause];
    self.isPlaying = NO;
}

/**
 恢复播放
 */
- (void)resumePlay{
    [self.player play];
    self.isPlaying = YES;
}

/**
 重新播放
 */
- (void)resetPlay{
    
}

/**
 快进
 */
-(void)speedPlay{
    
}


/**
 回退
 */
-(void)rollbackPlay{
    
}

/**
 跳转到指定的时间
 */
-(void)jumpToAppointedTime:(CGFloat)time{
    CMTime changeTime = CMTimeMake(time, 1);
    [self.playItem seekToTime:changeTime completionHandler:^(BOOL finished) {
        
    }];
}

- (void)dealloc
{
    [self.playItem removeObserver:self forKeyPath:@"status"];
}

@end
