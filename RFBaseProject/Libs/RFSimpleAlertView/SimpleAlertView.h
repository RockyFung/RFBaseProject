//
//  SimpleAlertView.h
//  RFAlertView
//
//  Created by rocky on 2018/11/5.
//  Copyright © 2018 rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelctBtnBlock)(NSInteger index, NSString*_Nullable btnTitle);
@interface SimpleAlertView : UIView

// 内容
@property (nonatomic, strong) UILabel * _Nullable messageLb;

@property (nonatomic, copy) SelctBtnBlock _Nullable selctBtnBlock;

- (void)show;

// 不带icon
- (instancetype _Nullable )initWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle;

// 带icon
- (instancetype _Nullable )initWithTitle:(nullable NSString *)title iconName:(nullable NSString *)iconName subTitle:(nullable NSString *)subTitle message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle;

@end
