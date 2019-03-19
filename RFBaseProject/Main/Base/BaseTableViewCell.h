//
//  BaseTableViewCell.h
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/28.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

- (void)initializeParameter; // 初始化参数
- (void)createUI; 

@end

NS_ASSUME_NONNULL_END
