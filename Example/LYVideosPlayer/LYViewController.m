//
//  LYViewController.m
//  LYVideosPlayer
//
//  Created by 萝卜 on 05/16/2019.
//  Copyright (c) 2019 萝卜. All rights reserved.
//

#import "LYViewController.h"
#import <LYVideosPlayer/LYPlayer.h>

@interface LYViewController ()

@property (nonatomic,strong) LYPlayer *player;

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.player = [[LYPlayer alloc]initWithVideoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" VideoView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

@end
