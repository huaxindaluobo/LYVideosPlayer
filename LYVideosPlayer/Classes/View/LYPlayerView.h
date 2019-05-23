//
//  LYPlayerView.h
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/22.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYBaseView.h"
@class LYPlayerView;

NS_ASSUME_NONNULL_BEGIN

@protocol LYPlayViewDelegate <NSObject>

-(void)shareVideoWithlayerView:(LYPlayerView*)playerView;

-(void)moreActionWithlayerView:(LYPlayerView*)playerView;

-(void)backActionWithlayerView:(LYPlayerView*)playerView;

/**
 点击播放暂停

 @param playerView self
 @param isplaying 当前是否在播放
 */
-(void)playVideoWithPlayerView:(LYPlayerView*)playerView isPLaying:(BOOL)isplaying;


/**
 点击最大化最小化

 @param playerView self
 @param isMax 当前是最大化还是最小化
 */
-(void)maxOrMinVideoWithPlayerView:(LYPlayerView *)playerView isMax:(BOOL)isMax;

-(void)trackVideoWithPlayerView:(LYPlayerView *)playerView SliderValue:(CGFloat)value;



@end

@interface LYPlayerView : LYBaseView

@property (nonatomic,weak) id<LYPlayViewDelegate> delegate;

-(void)changeSliderValue:(CGFloat)value;

@property (nonatomic,assign) BOOL isFullScreen;

@end

NS_ASSUME_NONNULL_END
