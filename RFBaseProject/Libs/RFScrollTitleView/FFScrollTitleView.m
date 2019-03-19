//
//  FFScrollTitleView.m
//  FanFan
//
//  Created by 冯剑 on 2018/3/9.
//  Copyright © 2018年 wang.com. All rights reserved.
//

#import "FFScrollTitleView.h"
@interface FFScrollTitleView()
@property (nonatomic,weak) UIButton *selectBtn;//选中的btn

@property (nonatomic,strong) NSArray * buttonArrs;//存储上方的按钮
@end

@implementation FFScrollTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_White;
    }
    return self;
}
- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, FitValue(50))];
    if (self) {
        self.backgroundColor = Color_White;
        self.titleArray = titleArray;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_White;
        self.titleArray = titleArray;
    }
    return self;
}


- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self creatUI];
}
- (void)creatUI{
    // 移除所以子view
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *arrM= [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (int i=0;i<_titleArray.count;i++){
        UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.width/_titleArray.count, 0, self.width/_titleArray.count, self.height-2)];
        [changeBtn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [changeBtn setTitleColor:Color_MLBlack
                        forState:UIControlStateNormal];
        [changeBtn setTitleColor:Color_MLBlue forState:UIControlStateSelected];
        changeBtn.titleLabel.font = FitFont(16);
        changeBtn.backgroundColor = [UIColor whiteColor];
        changeBtn.tag = i;
        [changeBtn addTarget:self action:@selector(scrollViewChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeBtn];
        [arrM addObject:changeBtn];
    }
    self.buttonArrs = arrM.copy;
    
    //橙色分割线
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 0.5)];
    orangeView.backgroundColor = Color_MLBlue;
    [self addSubview:orangeView];
    self.breakLine = orangeView;
    
    //橙色指示条
    UIView *indicateV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2, 0, 2)];
    indicateV.width = [(NSString *)_titleArray[0] widthForFont:FitFont(16)];
    UIButton *btn = (UIButton *)self.buttonArrs[0];
    indicateV.centerX = btn.centerX;
    indicateV.backgroundColor = Color_MLBlue;
    [self addSubview:indicateV];
    self.indicateV = indicateV;
}
- (void)setBtnIndex:(NSInteger)btnIndex{
    _btnIndex = btnIndex;
    if (_btnIndex > _buttonArrs.count-1) {
        return;
    }
    UIButton *btn = _buttonArrs[btnIndex];
    [self scrollViewChange:btn];
}
#pragma mark --切换btn点击事件
- (void)scrollViewChange:(UIButton *)sender{
    if (sender == self.selectBtn) {
        return;
    }
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeBtnDelegate:)]) {
        [self.delegate changeBtnDelegate:sender.tag];
    }
    self.indicateV.width = [self.titleArray[sender.tag] widthForFont:FitFont(16)];
    [UIView animateWithDuration:0.1 animations:^{
        self.indicateV.centerX = sender.centerX;
    }];
}

@end
