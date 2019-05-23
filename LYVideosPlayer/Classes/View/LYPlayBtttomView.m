//
//  LYPlayBtttomView.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/23.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYPlayBtttomView.h"
#import <Masonry/Masonry.h>
@interface LYPlayBtttomView ()

@end

@implementation LYPlayBtttomView

- (void)setupUI{
    self.playBtn = [[UIButton alloc]init];
    [self addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    self.maxBtn = [[UIButton alloc]init];
    [self addSubview:self.maxBtn];
    [self.maxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    self.slider = [[UISlider alloc]init];
    self.slider.minimumTrackTintColor = [UIColor grayColor];
    self.slider.maximumTrackTintColor = [UIColor blueColor];
    self.slider.value = 0.0;
    [self addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playBtn.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(self.maxBtn.mas_left).mas_equalTo(-10);
        make.centerY.mas_equalTo(self.playBtn.mas_centerY);
        make.height.mas_equalTo(48);
    }];
    
    [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    
    [self.maxBtn setImage:[UIImage imageNamed:@"max"] forState:UIControlStateNormal];
    [self.maxBtn setImage:[UIImage imageNamed:@"min"] forState:UIControlStateSelected];
    
}

@end
