//
//  AppDelegate.m
//  RFBaseProject
//
//  Created by 冯剑 on 2019/3/19.
//  Copyright © 2019 rocky. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "GuidePagesVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [self pickViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

// 选择主视图
- (UIViewController*)pickViewController{
    // 获取老的版本号
        NSString *oldAppVersion = [kUserDefaults stringForKey:KOldAppVersionKey];
    // 如果版本号不一样显示引导页
    BaseTabBarController *root = [[BaseTabBarController alloc]init];
        if (![oldAppVersion isEqualToString:AppVersion]) {
            GuidePagesVC *guide = [[GuidePagesVC alloc]init];
            guide.imageDatas = @[@"guidePage1", @"guidePage1", @"guidePage1"];
            guide.rootViewController = root;
            [kUserDefaults setObject:AppVersion forKey:KOldAppVersionKey];
            return guide;
        }else {
            return root;
        }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
