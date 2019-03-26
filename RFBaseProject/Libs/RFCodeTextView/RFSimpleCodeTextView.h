//
//  RFSimpleCodeTextView.h
//  rv-app
//
//  Created by 冯剑 on 2019/3/26.
//  Copyright © 2019 aomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RFSimpleCodeTextViewDelegate <NSObject>

- (void)inputCodeFinish:(NSString *)code;

@end

@interface RFSimpleCodeTextView : UIView
/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, weak) id<RFSimpleCodeTextViewDelegate> delegate;


- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
