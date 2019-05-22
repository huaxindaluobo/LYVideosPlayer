//
//  LYPlayer.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYPlayerManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVKit/AVKit.h>
#import <LYVideosPlayer/LYPlayerView.h>
@interface LYPlayerManager ()

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) AVPlayerItem *playItem;

@property (nonatomic,strong) AVPlayerLayer *playLayer;

@property (nonatomic,strong) LYPlayerView  * playView;


@end

@implementation LYPlayerManager

- (instancetype)initWithVideoUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.playItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
        self.player = [AVPlayer playerWithPlayerItem:self.playItem];
        self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        [self.playView.layer addSublayer:self.playLayer];
    }
    return self;
}

/**
 根据指定url在指定视图上播放视频
 
 @param playView 播放视图
 @param url 播放地址
 */
- (void)playVideoWithView:(UIView *)playView url:(NSString *)url{
    
}

/**
 停止播放并移除播放视图
 */
- (void)removeVideo{
    
}

/**
 暂停播放
 */
- (void)pausePlay{
    
}

/**
 恢复播放
 */
- (void)resumePlay{
    
}

/**
 重新播放
 */
- (void)resetPlay{
    
}



@end
