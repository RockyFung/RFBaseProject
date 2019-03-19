//
//  LaunchAdController.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/12/27.
//  Copyright © 2018 XJA. All rights reserved.
//

#import "LaunchAdController.h"
#import "XHLaunchAd.h"

@interface LaunchAdController()<XHLaunchAdDelegate>
@end
@implementation LaunchAdController
+(void)load{
    [self shareManager];
}

+(LaunchAdController *)shareManager{
    static LaunchAdController *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[LaunchAdController alloc] init];
    });
    return instance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
#ifdef DEBUG
            
#else
            [self setupLaunchAd];
#endif
        }];
    }
    return self;
}

- (void)setupLaunchAd{

    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 6;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"miaolai20190111.mp4";
    //是否关闭音频
    videoAdconfiguration.muted = YES;
    //视频填充模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = YES;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel =  @"";
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeRoundProgressTime;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.5;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //videoAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件 %@",openModel);
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel==nil) {
        return;
    }
    
//    [XHLaunchAd removeAndAnimated:NO];
//    FFWebViewController *webVC = [[FFWebViewController alloc]init];
//    webVC.urlStr = openModel;
//    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
//    [rootVC.myNavigationController  pushViewController:webVC animated:YES];
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}
/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
    
    NSLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
}

/**
 广告显示完成
 
 @param launchAd XHLaunchAd
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    
}


@end
