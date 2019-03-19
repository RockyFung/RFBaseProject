//
//  RFIconLabelBtn.h
//  RFIconLabelBtn
//
//  Created by 冯剑 on 2017/9/29.
//  Copyright © 2017年 冯剑. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,RFIconLabelBtnType) {
    RFIconLabelBtnLeftImageType,//左图标，右文字
    RFIconLabelBtnTopImageType,//上图标，下文字
    RFIconLabelBtnRightImageType//右图标，左文字
};



@interface RFIconLabelBtn : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isShowSelectBackgroudColor;//是否展示点击效果

@property (nonatomic, copy)void(^touchBlock)(RFIconLabelBtn *button);



/*
 初始化
 imageSize  图标大小
 isAutoWidth 是否根据文字长度自适应
 */
- (id)initWithFrame:(CGRect)frame
               type:(RFIconLabelBtnType)type
          imageSize:(CGSize)imageSize
          midmargin:(CGFloat)midmargin;

//点击响应
- (void)touchAction:(void(^)(RFIconLabelBtn *button))block;



NS_ASSUME_NONNULL_END
@end
