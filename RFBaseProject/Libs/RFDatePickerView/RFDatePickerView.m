//
//  RFDatePickerView.m
//  RFDatePickerView
//
//  Created by 冯剑 on 2019/1/11.
//  Copyright © 2019 rocky. All rights reserved.
//

#import "RFDatePickerView.h"

/**屏幕宽度*/
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
/**屏幕高度*/
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define FitValue(value) ((value) / 375.0) * [UIScreen mainScreen].bounds.size.width

/**颜色*/
#define RFColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HeaderViewHeight FitValue(45)

typedef NS_OPTIONS (NSInteger, HeaderViewButtonType) {
    HeaderViewButtonTypeCancel,
    HeaderViewButtonTypeConfirm
};

@interface RFDatePickerView()
///容器view
@property (nonatomic, weak) UIView *containView;
///pickerView
@property (nonatomic, weak) UIDatePicker *datePickerView;
@end

static RFDatePickerView *_view = nil;
static NSString *_format;
static UIDatePickerMode _pickerModel;

@implementation RFDatePickerView

+ (instancetype)showPickerViewWithModel:(UIDatePickerMode)model  formate:(NSString *)formate DateBlock:(void (^)(NSString *dateStr))dateBlock {
    _pickerModel = model;
    _format = formate;
    _view = [[RFDatePickerView alloc] init];
    //显示view
    _view.selectedBlock = dateBlock;
    [_view pickerViewShow];
    return _view;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, FitValue(45+220));
    [self addSubview:containView];
    self.containView = containView;
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, HeaderViewHeight);
    toolBar.backgroundColor = RFColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, FitValue(100), HeaderViewHeight)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RFColor(0x666666) forState:UIControlStateNormal];
    cancelBtn.tag = HeaderViewButtonTypeCancel;
    [toolBar addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-FitValue(100), 0, FitValue(100), HeaderViewHeight)];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:RFColor(0x666666) forState:UIControlStateNormal];
    confirmBtn.tag = HeaderViewButtonTypeConfirm;
    [toolBar addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
    datePickerView.backgroundColor = RFColor(0xffffff);
    datePickerView.datePickerMode = _pickerModel;
    datePickerView.frame = CGRectMake(0, toolBar.frame.size.height, ScreenWidth, FitValue(220));
    [datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [containView addSubview:datePickerView];
    self.datePickerView = datePickerView;
}

- (void)setCurrentDate:(NSString *)currentDate{
    _currentDate = currentDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_format];
    NSDate *date = [dateFormatter dateFromString:self.currentDate];
    self.datePickerView.date = date;
}

- (void)dateChanged:(UIDatePicker *)pickerView {
    NSLog(@"==> %@", pickerView.date);
}

- (void)buttonClick:(UIButton *)sender {
    
    [self pickerViewHiden];
    
    if (sender.tag == HeaderViewButtonTypeConfirm) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:_format];
        NSString *strDate = [dateFormatter stringFromDate:self.datePickerView.date];
        
        if (self.selectedBlock) {
            self.selectedBlock(strDate);
        }
    }
}


//显示
- (void)pickerViewShow{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        CGRect f = self.containView.frame;
        f.origin.y = ScreenHeight - f.size.height;
        self.containView.frame = f;
    }];
}

//隐藏
- (void)pickerViewHiden {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        CGRect f = self.containView.frame;
        f.origin.y = ScreenHeight;
        self.containView.frame = f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}









@end
