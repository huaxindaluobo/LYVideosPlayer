//
//  LYPlayer.h
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LYVideoPlayerStatusPrepared,//准备播放
    LYVideoPlayerStatusPause,//暂停播放
    LYVideoPlayerStatusPlaying,//正在播放
    LYVideoPlayerStatusUnload,//播放器未加载
    LYVideoPlayerStatusEnd,//播放结束
    LYVideoPlayerStatusError,//播放出错
} LYVideoPlayerStatus;

@class LYPlayerManager;

@protocol LYPlayerDelegate <NSObject>

-(void)lyplay:(LYPlayerManager *)player status:(LYVideoPlayerStatus)status;

@end

@interface LYPlayerManager : NSObject

@property (nonatomic,assign) BOOL isPlaying;

@property (nonatomic,assign) LYVideoPlayerStatus currentStatus;

@property (nonatomic,weak)id<LYPlayerDelegate> delegate;


/**
 根据指定url在指定视图上播放视频
 
 @param playView 播放视图
 @param url 播放地址
 */
- (void)playVideoWithView:(UIView *)playView url:(NSString *)url;

/**
 停止播放并移除播放视图
 */
- (void)removeVideo;

/**
 暂停播放
 */
- (void)pausePlay;

/**
 恢复播放
 */
- (void)resumePlay;

/**
 重新播放
 */
- (void)resetPlay;


@end

NS_ASSUME_NONNULL_END
