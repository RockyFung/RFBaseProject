//
//  BaseViewController.m
//  XJAfenshi
//
//  Created by rocky on 2018/10/31.
//  Copyright © 2018 XJA. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "SimpleAlertView.h"
#import "SimpleWebViewVC.h"
@interface BaseViewController ()
@property (nonatomic, strong) UIScrollView *keyboardTargetView;
@property (nonatomic, copy) GetPhotoImageBlock getImageBlock;
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //去掉iOS7后tableview header的延伸高度。。适配iOS7
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            //去掉iOS7透明效果
            self.navigationController.navigationBar.translucent = NO;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *pageName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"进入了%@", pageName);
//    [MobClick beginLogPageView:pageName];
//    [MobClick event:pageName];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString *pageName = [NSString stringWithUTF8String:object_getClassName(self)];
//    [MobClick endLogPageView:pageName];
    NSLog(@"离开了%@", pageName);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_MLGrayBG;
    self.navigationController.navigationBar.translucent = NO;
    
}

// 键盘监控
- (void)addKeyboardObserverTarget:(UIScrollView *)targetView{
    [KNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [KNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.keyboardTargetView = targetView;
}
#pragma mark -- setterTitle
- (void)setTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:FitValue(18)];
    label.font = FitFont(18);
    label.textColor = Color_MLBlack;
    label.textAlignment = 1;
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark--状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark--获取AppDelegate
- (AppDelegate *)appDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (UIButton *)setLeftBarBtnWithSpace:(CGFloat)space btnSize:(CGSize)btnSize iconNamed:(NSString *)iconNamed target:(nullable id)target action:(nonnull SEL)action{
    UIView *leftBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(space, 0, btnSize.width, btnSize.height)];
    [leftBg addSubview:leftBtn];
    if (iconNamed) {
        [leftBtn setImage:KImageNamed(iconNamed) forState:UIControlStateNormal];
        [leftBtn setImage:KImageNamed(iconNamed) forState:UIControlStateHighlighted];
    }
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBg];
    return leftBtn;
}
- (UIButton *)setRightBarBtnWithSpace:(CGFloat)space btnSize:(CGSize)btnSize iconNamed:(NSString *)iconNamed target:(nullable id)target action:(nonnull SEL)action{
    UIView *rightBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(space, 0, btnSize.width, btnSize.height)];
    [rightBg addSubview:rightBtn];
    if (iconNamed) {
        [rightBtn setImage:KImageNamed(iconNamed) forState:UIControlStateNormal];
        [rightBtn setImage:KImageNamed(iconNamed) forState:UIControlStateHighlighted];
    }
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBg];
    return rightBtn;
}


// 登录
- (void)gotoLogin{
    
}

// 弹窗
- (void)popAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)cancelBtn otherBtn:(NSString *)otherBtn hander:(void(^)(NSInteger index))hander{
    SimpleAlertView *alertView = [[SimpleAlertView alloc]initWithTitle:title subTitle:nil message:message cancelButtonTitle:cancelBtn otherButtonTitle:otherBtn];
    alertView.selctBtnBlock = ^(NSInteger index, NSString * _Nullable btnTitle) {
        if (hander) {
            hander(index);
        }
    };
    [alertView show];
}

// 拨打客服电话
- (void)callServicePhone{
    NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",KServicePhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (void)gotoSmartService{
    SimpleWebViewVC *web = [[SimpleWebViewVC alloc]init];
    web.urlStr = @"https://webchat.7moor.com/wapchat.html?accessId=1d3e7990-12f2-11e9-9f06-710c554ccf30&fromUrl=&urlTitle=";
    [self.navigationController pushViewController:web animated:YES];
}

// 是否登录
- (BOOL)isLogin{
    return [UserManager share].userModel.token;
}

// 是否开始接单
- (BOOL)isBegainOrder{
    return [UserManager share].userModel.driverWorking;
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note{
    if (self.keyboardTargetView == nil) {
        return;
    }
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardTargetView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}

#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note{
    if (self.keyboardTargetView == nil) {
        return;
    }
    self.keyboardTargetView.contentInset = UIEdgeInsetsZero;
}

- (void)callPhotoIsLib:(BOOL)isLib handler:(GetPhotoImageBlock)handler{
    self.getImageBlock = handler;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (isLib) {
            [self openCamera];
        }else{
            [self openFrountCamera];
        }
    }]];
    if (isLib) {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openPhotoLibrary];
        }]];
    }
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

// 调用照相机
- (void)openCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"没有后置摄像头");
    }
}
// 调用前置照相机
- (void)openFrountCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]){
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"没有前置摄像头");
    }
}

//打开相册
-(void)openPhotoLibrary{
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            NSLog(@"打开相册");
        }];
    }else{
        NSLog(@"不能打开相册");
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.getImageBlock) {
            self.getImageBlock(image);
        }
    }];
}

//从相机或者相册界面弹出
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    [KNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [KNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"%@控制器释放了", [NSString stringWithUTF8String:object_getClassName(self)]);
}


@end
