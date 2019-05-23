//
//  LYPlayTopVIew.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/23.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYPlayTopVIew.h"
#import <Masonry/Masonry.h>

@interface LYPlayTopVIew ()


@end

@implementation LYPlayTopVIew

- (void)setupUI{
    self.backBtn = [[UIButton alloc]init];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(48,48));
    }];
    
    self.shareBtn = [[UIButton alloc]init];
    [self addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(48,48));
    }];
    
    self.moreBtn = [[UIButton alloc]init];
    [self addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shareBtn.mas_left).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(48,48));
        make.centerY.mas_equalTo(self.shareBtn.mas_centerY);
    }];
    
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:@"share"
                             ] forState:UIControlStateNormal];
}

@end
