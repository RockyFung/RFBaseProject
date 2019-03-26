//
//  FirstViewController.m
//  RFBaseProject
//
//  Created by 冯剑 on 2019/3/19.
//  Copyright © 2019 rocky. All rights reserved.
//

#import "FirstViewController.h"
#import "RFSimpleCodeTextView.h"
@interface FirstViewController ()<RFSimpleCodeTextViewDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RFSimpleCodeTextView *codeView = [[RFSimpleCodeTextView alloc] initWithCount:4 margin:Gap_20];
    codeView.frame = CGRectMake((kScreenWidth-FitValue(220))/2, FitValue(100), FitValue(220), FitValue(40));
    codeView.delegate = self;
    [self.view addSubview:codeView];
}

#pragma mark - login
- (void)requestData{
    [PPHTTPRequest getLoginWithParameters:@{@"username":@"", @"password":@""} success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - RFSimpleCodeTextViewDelegate
- (void)inputCodeFinish:(NSString *)code{
    NSLog(@"自动登陆");
}
@end
