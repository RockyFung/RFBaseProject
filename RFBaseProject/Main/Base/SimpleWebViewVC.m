//
//  SimpleWebViewVC.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/29.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import "SimpleWebViewVC.h"
#import <WebKit/WebKit.h>
#import <ShareSDK/ShareSDK.h>
#import "FJActionSheetView.h"

@interface SimpleWebViewVC ()<WKNavigationDelegate>
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UIView *mainView;
@property(nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *shareBar; // 分享bar
@end

@implementation SimpleWebViewVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMainView];
    [self creatWebView];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 添加进度条
- (void)addMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight)];
    mainView.backgroundColor = [UIColor clearColor];
    _mainView = mainView;
    [self.view addSubview:mainView];
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    progressView.progress = 0;
    _progressView = progressView;
    [self.view addSubview:progressView];
}

- (void)creatWebView {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    
    [self.mainView addSubview:_webView];
    // 添加观察者
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL]; // 进度
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL]; // 标题
    
    if (self.urlStr) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [_webView loadRequest:request];
    }
    
    if (self.canShare) {
        [self addShareBarBtn];
    }
}
/*
- (void)setUrl:(NSURL *)url {
    _url = url;
    __weak typeof(self) WeakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:WeakSelf.url];
    [_webView loadRequest:request];
}
 */

- (void)addShareBarBtn{
    UIView *rightBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, rightBg.width, rightBg.height)];
    [rightBg addSubview:rightBtn];
    [rightBtn setImage:KImageNamed(@"home-share") forState:UIControlStateNormal];
    [rightBtn setImage:KImageNamed(@"home-share") forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBg];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 页面加载完毕时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}

#pragma mark - 监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    __weak typeof(self) WeakSelf = self;
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _webView) {
            [WeakSelf.progressView setAlpha:1.0f];
            [WeakSelf.progressView setProgress:WeakSelf.webView.estimatedProgress animated:YES];
            if(WeakSelf.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [WeakSelf.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [WeakSelf.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }  else if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"%@",WeakSelf.webView.title);
        if (object == WeakSelf.webView) {
            WeakSelf.title = WeakSelf.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 当对象即将销毁的时候调用
- (void)dealloc {
    NSLog(@"webView释放");
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    _webView.navigationDelegate = nil;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *jumpStr = navigationAction.request.URL.absoluteString;
    NSLog(@"跳转到 %@", jumpStr);
    decisionHandler(WKNavigationActionPolicyAllow); // 必须实现 不然会崩溃
}


- (void)shareAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.shareBar.y = kScreenHeight-self.shareBar.height-kSafeBottomMargin-kStatusBarAndNavigationBarHeight;
    }];
    FJActionSheetView *actionSheetView = [[FJActionSheetView alloc]initWithTitle:@"分享到" items:@[@"微信", @"朋友圈"] icons:@[@"share-weChat", @"share-weTime"] iconW:30 iconH:30];
    __weak typeof(self) WeakSelf = self;
    actionSheetView.block = ^(NSString *item){
        NSLog(@"%@",item);
        if ([item isEqualToString:@"微信"]) {
            [WeakSelf shareToWeChatWithType:SSDKPlatformSubTypeWechatSession];
        }else if([item isEqualToString:@"朋友圈"]){
            [WeakSelf shareToWeChatWithType:SSDKPlatformSubTypeWechatTimeline];
        }
    };
}


- (void)shareToWeChatWithType:(SSDKPlatformType)type{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"秒来货嘀"
                                     images:@[KImageNamed(@"share-logo")]
                                        url:[NSURL URLWithString:self.urlStr]
                                      title:self.title
                                       type:SSDKContentTypeAuto];
    
    //    SSDKPlatformSubTypeWechatSession
    //    SSDKPlatformSubTypeWechatTimeline
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"取消分享"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}
 
@end
