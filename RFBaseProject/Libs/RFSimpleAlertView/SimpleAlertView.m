
//
//  SimpleAlertView.m
//  RFAlertView
//
//  Created by rocky on 2018/11/5.
//  Copyright © 2018 rocky. All rights reserved.
//

#import "SimpleAlertView.h"

#define kScreenBounds ([UIScreen mainScreen].bounds)
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//#define FitValue(value) ((value) / 375.0) * [UIScreen mainScreen].bounds.size.width
//#define KImageNamed(name) [UIImage imageNamed:(name)]

#define Color_title [UIColor blackColor]
#define Color_titleBg [UIColor whiteColor]
#define Color_subTitle [UIColor blackColor]
#define Color_message [UIColor blackColor]

/// 按钮高度
#define BUTTON_HEIGHT FitValue(30)
/// 标题高度
#define TITLE_HEIGHT FitValue(40)

@interface SimpleAlertView()
// 取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
/** 其他按钮 */
@property (nonatomic, strong) UIButton *otherButton;
// 白色背景
@property (nonatomic, strong) UIView *bgView;
// 黑色背景
@property (nonatomic, strong) UIButton *shadeView;
// icon
@property (nonatomic, strong) UIImageView *icon;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 内容标题
@property (nonatomic, strong) UILabel *subTitleLb;
@end
@implementation SimpleAlertView

{
    NSString *_titleStr;
    NSString *_iconName;
    NSString *_subTitle;
    NSString *_message;
    NSString *_cancelBtnTitle;
    NSString *_otherBtnTitle;
    UIView *_line;
}

#pragma mark - init
// 不带icon
- (instancetype _Nullable )initWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle{
    if (self = [super initWithFrame:kScreenBounds]) {
        _titleStr = title;
        _iconName = nil;
        _subTitle = subTitle;
        _message = message;
        _cancelBtnTitle = cancelButtonTitle;
        _otherBtnTitle = otherButtonTitle;
        [self setupUI];
    }
    return self;
}

- (instancetype _Nullable )initWithTitle:(nullable NSString *)title iconName:(nullable NSString *)iconName subTitle:(nullable NSString *)subTitle message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle{
    if (self = [super initWithFrame:kScreenBounds]) {
        _titleStr = title;
        _iconName = iconName;
        _subTitle = subTitle;
        _message = message;
        _cancelBtnTitle = cancelButtonTitle;
        _otherBtnTitle = otherButtonTitle;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 设置底部遮罩
    _shadeView = [[UIButton alloc]initWithFrame:self.bounds];
    _shadeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [self addSubview:_shadeView];
//    [_shadeView addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    
    // 白色背景
    _bgView = [[UIButton alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    
    [_shadeView addSubview:self.bgView];
    
    
    // 设置标题富文本
    //    CGFloat iconHeight = 20;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = Color_title;
    _titleLabel.font = [UIFont systemFontOfSize:FitValue(16)];
    //    _titleLabel.attributedText = [self addIconLabelWithIconName:@"fanfantishi.png" title:_titleStr iconBounds:CGRectMake(0, -3, iconHeight,iconHeight)];
    _titleLabel.backgroundColor = Color_titleBg;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleStr;
    [self.bgView addSubview:self.titleLabel];
    
    // 设置icon
    if (_iconName.length > 0) {
        UIImageView *icon = [[UIImageView alloc]init];
        [icon setImage:KImageNamed(_iconName)];
        [self.bgView addSubview:icon];
        _icon = icon;
    }
    
    // 副标题
    if (_subTitle.length > 0 ) {
        _subTitleLb = [[UILabel alloc]init];
        _subTitleLb.font = [UIFont systemFontOfSize:FitValue(16)];
        _subTitleLb.textColor = Color_subTitle;
        _subTitleLb.textAlignment = NSTextAlignmentCenter;
        _subTitleLb.numberOfLines = 0;
        _subTitleLb.text = _subTitle;
        [self.bgView addSubview:_subTitleLb];
    }
    
    // 内容
    if (_message.length > 0) {
        _messageLb = [[UILabel alloc]init];
        _messageLb.font = [UIFont systemFontOfSize:FitValue(14)];
        _messageLb.textColor = Color_message;
        _messageLb.numberOfLines = 0;
        _messageLb.textAlignment = 1;
        _messageLb.text = _message;
        [self.bgView addSubview:_messageLb];
    }
    
    if (_cancelBtnTitle.length > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
        btn.RF_borderWidthColorRadius(1, Color_MLBlue, FitValue(5))
        .RF_fontAndColor(FitValue(14), Color_MLBlack);
        btn.tag = 100;
        self.cancelButton = btn;
        [self.bgView addSubview:btn];
    }
    
    
    if (_otherBtnTitle.length > 0) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:_otherBtnTitle forState:UIControlStateNormal];
        btn2.RF_cornerRadius(FitValue(5)).RF_backgroundColor(Color_MLBlue)
        .RF_fontAndColor(FitValue(14), Color_White);
        btn2.tag = 101;
        self.otherButton = btn2;
        [self.bgView addSubview:btn2];
    }
    
    
    // line
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = Color_MLLine;
    _line = line;
    [self.bgView addSubview:line];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bgView.frame = CGRectMake(0, 0, kScreenWidth - FitValue(60), FitValue(280));
    _bgView.center = _shadeView.center;
    
    CGFloat y = 0;
    
    // 标题
    _titleLabel.frame = CGRectMake(0, y, _bgView.frame.size.width, TITLE_HEIGHT);
    y = TITLE_HEIGHT;
    
    // icon
    if (_iconName.length > 0) {
        CGFloat iconW = FitValue(50);
        _icon.frame = CGRectMake((_bgView.frame.size.width - iconW)/2, FitValue(15)+y, iconW, iconW);
        y = _icon.frame.origin.y + _icon.frame.size.height;
    }
    
    // 副标题
    if (_subTitle.length > 0) {
        CGSize msgTitleSize = [self sizeWithFont:_subTitleLb.font maxW:_bgView.frame.size.width - FitValue(40) string:_subTitle];
        _subTitleLb.frame = CGRectMake(FitValue(20), y+FitValue(20), _bgView.frame.size.width - FitValue(40), msgTitleSize.height);
        y = _subTitleLb.frame.origin.y+_subTitleLb.frame.size.height;
    }
    
    // 主内容
    if (_message.length > 0) {
        CGSize msg2Size = [self sizeWithFont:_messageLb.font maxW:_bgView.frame.size.width - FitValue(40) string:_message];
        _messageLb.frame = CGRectMake(FitValue(20), y+FitValue(10), _bgView.frame.size.width - FitValue(40), msg2Size.height+FitValue(20));
        y = _messageLb.frame.origin.y+_messageLb.frame.size.height;
    }
    
    // 更新背景高度
    CGRect temFrame =  _bgView.frame;
    temFrame.size.height = y + FitValue(60);
    _bgView.frame = temFrame;
    
    // 按钮
    CGFloat btnW = FitValue(120);
    CGFloat btnY = _bgView.frame.size.height - BUTTON_HEIGHT - FitValue(10);
    if (_cancelBtnTitle.length > 0 && _otherBtnTitle.length > 0) {
        CGFloat btnGap = (_bgView.width - btnW*2)/3;
        _cancelButton.frame = CGRectMake(btnGap, btnY, btnW, BUTTON_HEIGHT);
        _otherButton.frame = CGRectMake(_cancelButton.maxX+btnGap, btnY, btnW, BUTTON_HEIGHT);
    }else if(_cancelBtnTitle.length > 0 && _otherBtnTitle.length == 0){
        CGFloat btnGap = (_bgView.width - btnW)/2;
        _cancelButton.frame = CGRectMake(btnGap, btnY, btnW, BUTTON_HEIGHT);
    }else if(_otherBtnTitle.length > 0 && _cancelBtnTitle.length == 0){
        CGFloat btnGap = (_bgView.width - btnW)/2;
        _otherButton.frame = CGRectMake(btnGap, btnY, btnW, BUTTON_HEIGHT);
    }
    
    // line
    _line.frame = CGRectMake(0, _titleLabel.frame.origin.y+_titleLabel.frame.size.height-0.5, _bgView.frame.size.width, 0.5);
    
}

- (void)show {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformIdentity;
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        } completion:^(BOOL finished) {
        }];
    });
    
}

- (void)dissmiss {
    [self removeFromSuperview];
}


- (void)selectButtonClick:(UIButton *)btn {
    
    if (self.selctBtnBlock) {
        self.selctBtnBlock(btn.tag-100, btn.currentTitle);
        self.selctBtnBlock = nil;
    }
    [self dissmiss];
}

#pragma mark - private faction
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW string:(NSString *)string{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSMutableAttributedString *)addIconLabelWithIconName:(NSString *)iconName title:(NSString *)title iconBounds:(CGRect)iconBounds{
    // 添加图片对象
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:iconName];
    attch.bounds = iconBounds;
    // 创建带有图片的富文本
    NSAttributedString *icon = [NSAttributedString attributedStringWithAttachment:attch];
    
    // 创建label富文本对象
    NSMutableAttributedString *attri =    [[NSMutableAttributedString alloc] initWithString:title];
    // 把图片放到第一个位置
    [attri insertAttributedString:icon atIndex:0];
    return attri;
}


@end
