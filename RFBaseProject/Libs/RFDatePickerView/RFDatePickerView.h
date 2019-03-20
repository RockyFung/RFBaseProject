//
//  RFDatePickerView.h
//  RFDatePickerView
//
//  Created by 冯剑 on 2019/1/11.
//  Copyright © 2019 rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFDatePickerView : UIView

@property (nonatomic, copy) void(^selectedBlock)(NSString *dateStr);
@property (nonatomic, copy) NSString *currentDate;

+ (instancetype)showPickerViewWithModel:(UIDatePickerMode)model formate:(NSString *)formate DateBlock:(void (^)(NSString *dateStr))dateBlock;
@end

NS_ASSUME_NONNULL_END
