//
//  BaseViewController.h
//  XJAfenshi
//
//  Created by rocky on 2018/10/31.
//  Copyright © 2018 XJA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

typedef void(^GetPhotoImageBlock)(UIImage *image);
@interface BaseViewController : UIViewController

/** 需要回调的url Block */
@property (nonatomic, copy) void (^returnBlock)(void);
@property (nonatomic, copy) void (^returnBlockWithMsg)(NSString *msg);


//委托appdelegate
- (AppDelegate *)appDelegate;

// 登录
- (void)gotoLogin;

// 是否登录
- (BOOL)isLogin;

// 是否开始接单
- (BOOL)isBegainOrder;

// 拨打客服电话
- (void)callServicePhone;

// 智能客服
- (void)gotoSmartService;

// 键盘监控
- (void)addKeyboardObserverTarget:(UIScrollView *)targetView;

// 弹窗
- (void)popAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)cancelBtn otherBtn:(NSString *)otherBtn hander:(void(^)(NSInteger index))hander;

// 设置barbtn
- (UIButton *)setLeftBarBtnWithSpace:(CGFloat)space btnSize:(CGSize)btnSize iconNamed:(NSString *)iconNamed target:(nullable id)target action:(nonnull SEL)action;
- (UIButton *)setRightBarBtnWithSpace:(CGFloat)space btnSize:(CGSize)btnSize iconNamed:(NSString *)iconNamed target:(nullable id)target action:(nonnull SEL)action;

- (void)callPhotoIsLib:(BOOL)isLib handler:(GetPhotoImageBlock)handler;
@end
