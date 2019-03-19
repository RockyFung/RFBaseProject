//
//  BaseTabBarController.m
//  RFBaseProject
//
//  Created by 冯剑 on 2019/3/19.
//  Copyright © 2019 rocky. All rights reserved.
//

#import "BaseTabBarController.h"
#import "RDVTabBarItem.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    firstViewController.view.backgroundColor = [UIColor cyanColor];
    firstViewController.title = @"first";
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    secondViewController.title = @"second";
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    thirdViewController.title = @"third";
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    FouthViewController *fourViewController = [[FouthViewController alloc] init];
    fourViewController.title = @"fouth";
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:fourViewController];
    
    [self setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController, fourNavigationController]];
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController{
    // item的背景设置
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    
    
    // item 标题图片设置
    NSArray *tabBarItemImages = @[@"first", @"second", @"third", @""];
    NSArray *tabBarItemTitles = @[@"home", @"发现", @"列表", @"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:tabBarItemTitles[index]];
        index++;
    }
}


@end
