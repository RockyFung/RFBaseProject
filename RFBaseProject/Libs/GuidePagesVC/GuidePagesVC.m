//
//  GuidePagesVC.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/29.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import "GuidePagesVC.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface GuidePagesVC () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation GuidePagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init scrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    // init pageControl
    _pageControl =
    [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 10)];
    _pageControl.currentPage = 0;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //    [self.view addSubview:_pageControl];
    
    // init button
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addContentView];
}


//指定数据后，初始化显示内容
- (void)addContentView
{
    if (_imageDatas.count){
        _pageControl.numberOfPages = _imageDatas.count;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageDatas.count, SCREEN_HEIGHT);
        for (int i = 0; i < _imageDatas.count; i++)
        {
            NSString *imageName = _imageDatas[i];
            UIImageView *imgView =
            [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imgView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.scrollView addSubview:imgView];
            
            if (i == _imageDatas.count - 1)
            {
                _actionButton.frame =
                CGRectMake((SCREEN_WIDTH-FitValue(120))/2, SCREEN_HEIGHT - FitValue(120), FitValue(120), FitValue(40));
                _actionButton.layer.cornerRadius = FitValue(5);
                _actionButton.layer.masksToBounds = YES;
                [_actionButton setTitle:@"进  入" forState:UIControlStateNormal];
                [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _actionButton.layer.borderColor = [UIColor whiteColor].CGColor;
                _actionButton.layer.borderWidth = 1;
                [_actionButton addTarget:self
                                  action:@selector(enterButtonClick)
                        forControlEvents:UIControlEventTouchUpInside];
                [imgView addSubview:_actionButton];
                //设置可以响应交互，UIImageView的默认值为NO
                imgView.userInteractionEnabled = YES;
            }
        }
    }else{
        NSLog(@"请设置imageDatas参数");
    }
}

#pragma mark
#pragma mark Action
- (void)enterButtonClick
{
    if (self.rootViewController) {
        [UIApplication sharedApplication].keyWindow.rootViewController = self.rootViewController;
    }else{
        NSLog(@"请设置rootViewController参数");
    }
}

#pragma mark
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (_scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
}

@end
