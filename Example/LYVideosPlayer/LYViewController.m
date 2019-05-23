//
//  LYViewController.m
//  LYVideosPlayer
//
//  Created by 萝卜 on 05/16/2019.
//  Copyright (c) 2019 萝卜. All rights reserved.
//

#import "LYViewController.h"
#import <LYVideosPlayer/LYPlayer.h>
#import "LYPlayerView.h"
@interface LYViewController ()<UITableViewDelegate,LYPlayViewDelegate>

@property (nonatomic,strong) LYPlayer *player;

@property (nonatomic,strong) LYPlayerView *playView;



@end

@implementation LYViewController

#pragma mark - 懒加载
- (LYPlayerView *)playView {
    if (!_playView) {
        _playView = [[LYPlayerView alloc]init];
        _playView.isFullScreen = YES;
        _playView.delegate = self;
    }
    return _playView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.player = [[LYPlayer alloc]initWithVideoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" VideoView:self.playView];
    __weak typeof(self) weakSelf = self;
    self.player.block = ^(CGFloat value) {
        [weakSelf.playView changeSliderValue:value];
    };
    //生成屏幕旋转通知
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    //注册屏幕旋转通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(originChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}

-(void)originChanged:(NSNotification *)noti{
    UIDeviceOrientation origin = [UIDevice currentDevice].orientation;
    switch (origin) {
        case UIDeviceOrientationPortrait:{
            NSLog(@"竖直屏幕");
            [self.playView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(200);
            }];
            [self.playView layoutIfNeeded];
            [self.player videoOriginChange:origin VideoView:self.playView];
        }
            break;
        case UIDeviceOrientationLandscapeLeft:{
            NSLog(@"手机左转");
            [self.playView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.view.frame.size.height);
            }];
            [self.playView layoutIfNeeded];
            [self.player videoOriginChange:origin VideoView:self.playView];
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
        {
            NSLog(@"手机竖直");
        }
           
            break;
        case UIDeviceOrientationLandscapeRight:{
            NSLog(@"手机右转");
            [self.playView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.view.frame.size.height);
            }];
            [self.playView layoutIfNeeded];
            [self.player videoOriginChange:origin VideoView:self.playView];
        }
           
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知");
            break;
        case UIDeviceOrientationFaceUp:
            NSLog(@"手机屏幕朝上");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"手机屏幕朝下");
            break;
        default:
            break;
    }
}

#pragma mark == playViewDelegate

-(void)shareVideoWithlayerView:(LYPlayerView*)playerView{
    
}

-(void)moreActionWithlayerView:(LYPlayerView*)playerView{
    
}

-(void)backActionWithlayerView:(LYPlayerView*)playerView{
    
}

/**
 点击播放暂停
 
 @param playerView self
 @param isplaying 当前是否在播放
 */
-(void)playVideoWithPlayerView:(LYPlayerView*)playerView isPLaying:(BOOL)isplaying{
    if (isplaying) {
        [self.player pausePlay];
    }else{
        [self.player resumePlay];
    }
}


/**
 点击最大化最小化
 
 @param playerView self
 @param isMax 当前是最大化还是最小化
 */
-(void)maxOrMinVideoWithPlayerView:(LYPlayerView *)playerView isMax:(BOOL)isMax{
    if (isMax) {
        //设置竖屏
        NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];

    }else{
        //设置横屏
        NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

-(void)trackVideoWithPlayerView:(LYPlayerView *)playerView SliderValue:(CGFloat)value{
    self.player.currentTime = self.player.videoTime*value;
    [self.player jumpToAppointedTime:self.player.currentTime];
}

@end
