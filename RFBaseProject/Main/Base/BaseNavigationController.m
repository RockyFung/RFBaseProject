//
//  BaseNavigationController.m
//  XJAfenshi
//
//  Created by rocky on 2018/10/31.
//  Copyright © 2018 XJA. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    //添加返回手势
    self.interactivePopGestureRecognizer.delegate = self;
}

// 重写导航控制器的push方法 让所有push进来的控制器 都隐藏bottom bar
- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        UIView *btnBg = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 30, 30)];
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(-10, 0, 30, 30)];
        [btnBg addSubview:leftBtn];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"jiantou-back"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"jiantou-back"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btnBg];
        
        viewController.navigationItem.leftBarButtonItem = leftBar;
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)backAction {
    [self popViewControllerAnimated:YES];
}

// 状态栏 白色 uiapplication statusBarorientation
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
