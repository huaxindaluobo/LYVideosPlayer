//
//  LYPlayerView.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/22.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYPlayerView.h"
#import "LYPlayBtttomView.h"
#import <Masonry/Masonry.h>
#import "LYPlayTopVIew.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
    UIPanGestureRecognizerDirectionUndefined,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
    UIPanGestureRecognizerDirectionLeft,
    UIPanGestureRecognizerDirectionRight
};

@interface LYPlayerView ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)LYPlayBtttomView  *bottomView;

@property (nonatomic,strong) LYPlayTopVIew *topView;

@property (nonatomic,assign) CGPoint currentPoint;


@end

@implementation LYPlayerView

#pragma mark - 懒加载
- (LYPlayTopVIew *)topView {
    if (!_topView) {
        _topView = [[LYPlayTopVIew alloc]init];
        [_topView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
         [_topView.moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
         [_topView.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _topView;
}

#pragma mark - 懒加载
- (LYPlayBtttomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LYPlayBtttomView alloc]init];
        [_bottomView.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.maxBtn addTarget:self action:@selector(maxAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _bottomView;
}



-(void)setupUI{
    
    UIImageView * backGroundImage = [[UIImageView alloc]init];
    backGroundImage.image = [UIImage imageNamed:@"backgroud"];
    [self addSubview:backGroundImage];
    [backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    //添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panClick:)];
    pan.delegate =self;
    [self addGestureRecognizer:pan];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _currentPoint = [[touches anyObject] locationInView:self];
}

-(void)panClick:(UIPanGestureRecognizer *)pan{
    if (!self.isFullScreen) {
        return;
    }
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
           CGPoint velocityPoint = [pan velocityInView:self];
            BOOL isVer = fabs(velocityPoint.y)>fabs(velocityPoint.x);
            if (isVer) {
                if (velocityPoint.y>0) {
                    direction = UIPanGestureRecognizerDirectionDown;
                }else{
                    direction = UIPanGestureRecognizerDirectionUp;
                }
            }else{
                if (velocityPoint.x>0) {
                    direction = UIPanGestureRecognizerDirectionRight;
                } else {
                    direction = UIPanGestureRecognizerDirectionLeft;
                }
            }
        }
            break;
            
            case UIGestureRecognizerStateChanged:
        {
            [self changeWithDirection:direction Pan:pan];
        }
            break;
            
        default:
            break;
    }
}

-(void)changeWithDirection:(UIPanGestureRecognizerDirection)direction Pan:(UIPanGestureRecognizer *)pan{
    CGPoint point= [pan locationInView:self];// 上下控制点
    CGPoint tranPoint=[pan translationInView:self];//播放进度
    switch (direction) {
        case UIPanGestureRecognizerDirectionUp:
        {
            float dy = point.y-_currentPoint.y;
            int index = (int)dy;
            if (_currentPoint.x<self.frame.size.width/2) {//亮度
                if(index >0){
                    [UIScreen mainScreen].brightness = [UIScreen mainScreen].brightness- 0.01;
                }else{
                    [UIScreen mainScreen].brightness = [UIScreen mainScreen].brightness+ 0.01;
                }
            }else{//音量
                if (index>0) {
                    //音量增加
//                    [UIDevice currentDevice].
                }else{
                    //音量减少
                }
            }
        }
            break;
        case UIPanGestureRecognizerDirectionDown:
        {
            float dy = point.y-_currentPoint.y;
            int index = (int)dy;
            if (_currentPoint.x<self.frame.size.width/2) {//亮度
                if(index >0){
                    [UIScreen mainScreen].brightness = [UIScreen mainScreen].brightness- 0.01;
                }else{
                    [UIScreen mainScreen].brightness = [UIScreen mainScreen].brightness+ 0.01;
                }
            }else{//音量
                if (index>0) {
                    //音量增加
                    //                    [UIDevice currentDevice].
                }else{
                    //音量减少
                }
            }
        }
            break;
        case UIPanGestureRecognizerDirectionLeft:
        {
            if(tranPoint.x/ScreenWidth+self.bottomView.slider.value<=0)  {
                self.bottomView.slider.value = 0;
                
            }else{
                self.bottomView.slider.value= tranPoint.x/ScreenWidth+self.bottomView.slider.value;
            }
            [self valueChange:self.bottomView.slider];
        }
            break;
        case UIPanGestureRecognizerDirectionRight:
        {
            if (tranPoint.x/ScreenWidth+self.bottomView.slider.value>=1) {
                self.bottomView.slider.value = 1;
            }else{
                self.bottomView.slider.value= tranPoint.x/ScreenWidth+self.bottomView.slider.value;
            }
            [self valueChange:self.bottomView.slider];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)changeSliderValue:(CGFloat)value{
    self.bottomView.slider.value = value;
}

#pragma mark == action

-(void)backAction{
    if ([self.delegate respondsToSelector:@selector(backActionWithlayerView:)]) {
        [self.delegate backActionWithlayerView:self];
    }
}

-(void)moreAction{
    if ([self.delegate respondsToSelector:@selector(moreActionWithlayerView:)]) {
        [self.delegate moreActionWithlayerView:self];
    }
}

-(void)shareAction{
    if ([self.delegate respondsToSelector:@selector(shareVideoWithlayerView:)]) {
        [self.delegate shareVideoWithlayerView:self];
    }
}

-(void)playAction:(UIButton *)playBtn{
    
    if ([self.delegate respondsToSelector:@selector(playVideoWithPlayerView:isPLaying:)]) {
        [self.delegate playVideoWithPlayerView:self isPLaying:playBtn.selected];
        playBtn.selected = !playBtn.selected;
    }
}

-(void)maxAction:(UIButton *)maxBtn{
    if ([self.delegate respondsToSelector:@selector(maxOrMinVideoWithPlayerView:isMax:)]) {
        [self.delegate maxOrMinVideoWithPlayerView:self isMax:maxBtn.selected];
        maxBtn.selected = !maxBtn.selected;
    }
}

-(void)valueChange:(UISlider * )slider{
    if ([self.delegate respondsToSelector:@selector(trackVideoWithPlayerView:SliderValue:)]) {
        [self.delegate trackVideoWithPlayerView:self SliderValue:slider.value];
    }
}

@end
