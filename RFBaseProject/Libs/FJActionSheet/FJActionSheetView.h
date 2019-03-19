//
//  FJActionSheetView.h
//  FJSimpleActionSheet
//
//  Created by rocky on 16/4/20.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetSelectBlock)(NSString *item);
@interface FJActionSheetView : UIView
@property (nonatomic, copy) ActionSheetSelectBlock block;
@property (nonatomic, assign) BOOL isUserQuit; // 是否用户手动退出
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items icons:(NSArray *)icons iconW:(CGFloat)iconW iconH:(CGFloat)iconH;
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items;
// 页面消失
- (void)dismissView;
@end
