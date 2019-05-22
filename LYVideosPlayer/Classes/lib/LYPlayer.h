//
//  LYPlayer.h
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYPlayer : NSObject

@property (nonatomic,assign,readonly) BOOL  isPlaying;

/**
 初始化视频播放器

 @param url video url
 @param videoView video view
 @return 播放器
 */
- (instancetype)initWithVideoUrl:(NSString *)url VideoView:(UIView *)videoView;

//切换视频
- (void)updatePlayerWithURL:(NSURL *)url 

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


/**
 快进
 */
-(void)speedPlay;


/**
 回退
 */
-(void)rollbackPlay;


/**
 跳转到指定的时间
 */
-(void)jumpToAppointedTime:(CGFloat)time;

@end

NS_ASSUME_NONNULL_END
