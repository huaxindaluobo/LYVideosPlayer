//
//  LYMainView.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYMainView.h"

@interface LYMainView ()

@property (nonatomic,strong) UILabel *nameLable;

@end

@implementation LYMainView


-(void)setupUI{
    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 20)];
    nameLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLable];
    self.nameLable = nameLable;
    
}

- (void)setModel:(LYMainModel *)model{
    _model = model;
    self.nameLable.text = model.name;
}


@end
