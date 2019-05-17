//
//  LYMainViewcontroller.m
//  LYVideosPlayer_Example
//
//  Created by 刘洋 on 2019/5/16.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYMainViewcontroller.h"
#import "LYMainView.h"
#import "LYMainModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LYMainViewcontroller ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LYMainView * topView;
@property (nonatomic,strong) LYMainView * middleView;
@property (nonatomic,strong) LYMainView * bottomView;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation LYMainViewcontroller

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"主界面";
    [self setupUI];
    [self loadData];
}

-(void)loadData{
    for (int i=0; i<10; i++) {
        LYMainModel * model = [[LYMainModel alloc]init];
        model.name = [NSString stringWithFormat:@"x名字===%d",i];
        [self.dataArray addObject:model];
    }
    self.currentIndex = 0;
    self.topView.model = self.dataArray[0];
    self.middleView.model =self.dataArray[1];
    self.bottomView.model = self.dataArray[2];
    
}

-(void)setupUI{
    [self.view addSubview:self.scrollView];
    
}



#pragma mark -- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentY = scrollView.contentOffset.y;
    if (contentY>=2*ScreenHeight) {//上滑
        if (self.currentIndex == 0) {
            self.currentIndex+=2;
            self.scrollView.contentOffset = CGPointMake(0, ScreenHeight);
            self.topView.model = self.middleView.model;
            self.middleView.model =self.bottomView.model;
            
        }else if(self.currentIndex<self.dataArray.count-1){
            self.currentIndex+=1;
            if (self.currentIndex == self.dataArray.count-1) {
                self.middleView.model = self.dataArray[self.currentIndex-1];
            }else{
                scrollView.contentOffset = CGPointMake(0, ScreenHeight);
                self.topView.model = self.middleView.model;
                self.middleView.model =self.bottomView.model;
                
            }
        }
        if (self.currentIndex<self.dataArray.count-1 && self.dataArray.count>3) {
             self.bottomView.model = self.dataArray[self.currentIndex+1];
        }
        
    }else if (contentY<=0){//下滑
        if (self.currentIndex ==1) {//第一张
            self.topView.model = self.dataArray[0];
            self.middleView.model = self.dataArray[1];
            self.bottomView.model = self.dataArray[2];
            self.currentIndex--;
            return;
        }else if(self.currentIndex>1){
            if (self.currentIndex== self.dataArray.count-1) {
                self.currentIndex-=2;
            }else{
                self.currentIndex--;
            }
            self.scrollView.contentOffset = CGPointMake(0, ScreenHeight);
            self.bottomView.model = self.middleView.model;
            self.middleView.model = self.topView.model;
        }
        if (self.currentIndex>0) {
            self.topView.model = self.dataArray[self.currentIndex-1];
        }
        
    }
}


#pragma mark -- 滑动结束修改数据
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentY = scrollView.contentOffset.y;
//    self.currentIndex++;
    if (contentY == 0) {
        
    }else if (contentY == ScreenHeight){
        
    }else{
        
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.topView];
        [_scrollView addSubview:self.middleView];
        [_scrollView addSubview:self.bottomView];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 3*ScreenHeight);
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.middleView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
        self.bottomView.frame = CGRectMake(0, 2*ScreenHeight, ScreenWidth, ScreenHeight);
    }
    return _scrollView;
}


- (LYMainView *)topView{
    if (!_topView) {
        _topView = [[LYMainView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (LYMainView *)middleView {
    if (!_middleView) {
        _middleView = [[LYMainView alloc]init];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}

- (LYMainView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LYMainView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
