//
//  BaseView.m
//  XJADriver
//
//  Created by 冯剑 on 2018/12/18.
//  Copyright © 2018 XJA. All rights reserved.
//

#import "BaseView.h"
@interface BaseView()

@end
@implementation BaseView
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.backgroundColor = Color_clear;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeParameter];
        [self addSubview:self.scrollView];
        [self createUI];
    }
    return self;
}
- (void)initializeParameter{
    self.backgroundColor = Color_clear;
}

- (void)createUI{
    
}

@end
