//
//  RFMacro.h
//  RFBaseProject
//
//  Created by 冯剑 on 2019/3/19.
//  Copyright © 2019 rocky. All rights reserved.
//

#ifndef RFMacro_h
#define RFMacro_h


/*****************************参数配置************************************/
///// UserDefaults key值 /////
#define KUserLocalCityKey @"UserLocalCityKey"
#define KServicePhone @"4006160728"
#define KMessagesKey @"MessagesKey"
#define KShowCancelOrder @"ShowCancelOrder"
#define KOldAppVersionKey @"KOldAppVersionKey"

////// 配置 ////////
#define KCitys @[@"上海市", @"台州市", @"桐乡市"] // 运行城市
#define KMapZoomLevel 14 //高德地图缩放级别（默认3-19，有室内地图时为3-20）
#define KAppScheme @"xjafenshi"
#define KJPushAppKey @"d5ef3eae4ab531f95d23e995" // 生产
#define KAMapAppKey @"01acff45efbfe379ef57bd9997756687" // 生产
#define KWeChatAppKey @"wx2de83a253c32d588" // 生产
#define KWeChatAppSecret @"a7a23ea3ff7094ffc0777aa620494127" // 生产
#define KBuglyAppKey @"d58beeaef7" // 个人

/////// userModel 存档路径
#define KUserModelFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userModel.data"]

/*****************************常用方法************************************/
// NSLog
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"😂 [%s:%d] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

// 系统参数获取
#define SystemVersion [UIDevice currentDevice].systemVersion
#define AppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define KUUIDString [[UIDevice currentDevice].identifierForVendor UUIDString]

//iphoneX适配差值
//判断是否iPhone X
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define kStatusBarHeight (IS_iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define kNavigationBarHeight 44.f
// Tabbar height.
#define kTabbarHeight (IS_iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define kSafeBottomMargin (IS_iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define kStatusBarAndNavigationBarHeight (IS_iPhoneX ? 88.f : 64.f)

// 尺寸
#define kScreenSize [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define FitValue(value) ((value) / 375.0) * [UIScreen mainScreen].bounds.size.width
#define Gap_5 FitValue(5)
#define Gap_10 FitValue(10)
#define Gap_20 FitValue(20)
#define Gap_30 FitValue(30)
// 字体大小
#define FitFont(value) [UIFont systemFontOfSize:((value / 375.0) * [UIScreen mainScreen].bounds.size.width)]
#define FitFontBold(value) [UIFont boldSystemFontOfSize:((value / 375.0) * [UIScreen mainScreen].bounds.size.width)]
#define Font_12 FitFont(12)
#define Font_14 FitFont(14)
#define Font_16 FitFont(16)
// 颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define Color_clear [UIColor clearColor]
#define Color_White [UIColor whiteColor]
#define Color_Black [UIColor blackColor]
#define Color_Gray [UIColor grayColor]
#define Color_MLGrayBG [UIColor hm_colorWithHex:0xF0F0F0]
#define Color_MLLine [UIColor hm_colorWithHex:0xDCDCDC]
#define Color_MLBlack [UIColor hm_colorWithHex:0x303030]
#define Color_MLGray [UIColor hm_colorWithHex:0xa2a2a2]
#define Color_MLBlue [UIColor hm_colorWithHex:0x4788FE]
#define Color_HYGreen [UIColor hm_colorWithHex:0xA1D165]
#define Color_HYYellow [UIColor hm_colorWithHex:0xFEAC00]

//通知的简写形式
#define KNotificationCenter [NSNotificationCenter defaultCenter]
// 获取主视图
#define KGetWindow [[UIApplication sharedApplication].delegate window]
// 获取UserDefaults
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 图片设置
#define KImageNamed(name) [UIImage imageNamed:(name)]


#endif /* RFMacro_h */
