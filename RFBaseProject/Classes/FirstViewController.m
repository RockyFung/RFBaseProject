//
//  FirstViewController.m
//  RFBaseProject
//
//  Created by 冯剑 on 2019/3/19.
//  Copyright © 2019 rocky. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - login
- (void)requestData{
    [PPHTTPRequest getLoginWithParameters:@{@"username":@"", @"password":@""} success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
