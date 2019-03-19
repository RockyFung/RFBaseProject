//
//  FFScrollTitleView.h
//  FanFan
//
//  Created by 冯剑 on 2018/3/9.
//  Copyright © 2018年 wang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FFScrollTitleViewDelegate<NSObject>
- (void)changeBtnDelegate:(NSInteger)index;
@end
@interface FFScrollTitleView : UIView
@property (nonatomic,strong) UIView *indicateV;// 指示条
@property (nonatomic, strong) UIView *breakLine; // 分割线

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) id<FFScrollTitleViewDelegate> delegate;
// 设置下标位置
@property (nonatomic, assign) NSInteger btnIndex;

// init
- (instancetype)initWithTitleArray:(NSArray *)titleArray;
- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray;
@end
