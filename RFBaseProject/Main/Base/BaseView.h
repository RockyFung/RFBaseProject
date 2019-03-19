//
//  BaseView.h
//  XJADriver
//
//  Created by 冯剑 on 2018/12/18.
//  Copyright © 2018 XJA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
- (void)initializeParameter; // 初始化参数
- (void)createUI; 
@end

NS_ASSUME_NONNULL_END
