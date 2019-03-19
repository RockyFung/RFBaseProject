//
//  GuidePagesVC.h
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/29.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuidePagesVC : UIViewController
// 图片数组 imageNamed
@property (nonatomic, strong) NSArray<NSString *> *imageDatas;
// 完成后跳转到主视图
@property (nonatomic, strong) UIViewController *rootViewController;

@end

NS_ASSUME_NONNULL_END
