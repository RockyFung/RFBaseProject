//
//  FJActionSheetView.m
//  FJSimpleActionSheet
//
//  Created by rocky on 16/4/20.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "FJActionSheetView.h"

#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KCellHeight FitValue(50)
#define KTitleHeight FitValue(40)
@interface FJActionSheetView()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, assign) CGFloat height;
@end


@implementation FJActionSheetView
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items{
    return  [self initWithTitle:title items:items icons:nil iconW:0 iconH:0];
}

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items icons:(NSArray *)icons iconW:(CGFloat)iconW iconH:(CGFloat)iconH
{
    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        [self setUserInteractionEnabled:YES];
        
        // 半透明背景
        self.bgBtn = [[UIButton alloc]init];
        self.bgBtn.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [self addSubview:self.bgBtn];
        self.bgBtn.backgroundColor = [UIColor blackColor];
        self.bgBtn.alpha = 0;
        [self.bgBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        

        
        self.height = items.count * KCellHeight + (title?KTitleHeight:0) + (IS_iPhoneX?kSafeBottomMargin:0); // 加上头部高度
        self.actionSheetView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - self.height , KScreenWidth, self.height)];
        self.actionSheetView.backgroundColor = [UIColor whiteColor];
        self.actionSheetView.alpha = 1;
        [self addSubview:self.actionSheetView];

        // 头部视图
        if (title) {
            UILabel *headeView = [[UILabel alloc]init]
            .RF_frame(0, 0, kScreenWidth, KTitleHeight)
            .RF_fontAndColor(FitValue(14),Color_MLGray)
            .RF_textAlignment(NSTextAlignmentCenter)
            .RF_text(title);
            [self.actionSheetView addSubview:headeView];
        }
        
        
        // actionSheet
        __block CGFloat _cellY = title?KTitleHeight:0;
        [items enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *sheetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _cellY, KScreenWidth, KCellHeight)];
            sheetBtn.tag = idx;
            [sheetBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.actionSheetView addSubview:sheetBtn];
            
            CGFloat titleX = 0;
            CGFloat titleW = KScreenWidth;
            if (icons.count > 0) {
                UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(FitValue(120), (KCellHeight-iconH)/2, iconW, iconH)];
                icon.image = KImageNamed(icons[idx]);
                [sheetBtn addSubview:icon];
                titleX = icon.maxX+Gap_10;
                titleW = KScreenWidth - titleX;
            }

            UILabel *titleL = [[UILabel alloc]init]
            .RF_frame(titleX,0,titleW,KCellHeight)
            .RF_fontAndColor(FitValue(14),Color_MLBlack)
            .RF_text(item);
            [sheetBtn addSubview:titleL];
            if (icons.count > 0) {
                titleL.textAlignment = NSTextAlignmentLeft;
            }else{
                titleL.textAlignment = NSTextAlignmentCenter;
            }
            
            // 添加分割线
            UIView *firstSplitter = [[UIView alloc] init];
            firstSplitter.frame = CGRectMake(Gap_20, _cellY, KScreenWidth-Gap_20*2, 0.5);
            firstSplitter.backgroundColor = Color_MLLine;
            [self.actionSheetView addSubview:firstSplitter];
            
            _cellY += KCellHeight;
        }];
        
        // 避开底部bar
        UIView *saveBottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-kSafeBottomMargin, KScreenWidth, kSafeBottomMargin)];
        saveBottom.backgroundColor = self.actionSheetView.backgroundColor;
        [self.actionSheetView addSubview:saveBottom];

        [self pushView];
    }
    return self;
}

// 是否需要手动退出
- (void)setIsUserQuit:(BOOL)isUserQuit{
    _isUserQuit = isUserQuit;
    if (isUserQuit) {
        self.bgBtn.userInteractionEnabled = NO;
    }else{
        self.bgBtn.userInteractionEnabled = YES;
    }
}

// clickBtn
- (void)clickAction:(UIButton *)btn{
    [btn.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *itemL = obj;
            if (self.block) {
                self.block(itemL.text);
                [self dismissView];
            }
        }
    }];
}

//出现
- (void)pushView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.actionSheetView.frame = CGRectMake(0, KScreenHeight - self.height, KScreenWidth, self.height);
        weakSelf.bgBtn.alpha = 0.3;
    }];
}

// 页面消失
- (void)dismissView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.actionSheetView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, self.height);
        weakSelf.bgBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.actionSheetView removeFromSuperview];
        [weakSelf.bgBtn removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}








@end
