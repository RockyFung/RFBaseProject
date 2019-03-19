//
//  UserManager.h
//  XJAfenshi
//
//  Created by 冯剑 on 2018/12/3.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserInfoModel;
@interface UserManager : NSObject

+ (UserManager* ) share;
// 接档
@property (nonatomic, strong) UserInfoModel *userModel;
// 存档
+ (BOOL)saveUserWithDict:(NSDictionary *)dict;
// 删除存档
-(BOOL)removeFile;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
// 用户
@interface UserInfoModel : NSObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *currentCity;

// 司机
@property (nonatomic, assign) NSInteger driverWorking; // 是否开始接单
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) NSInteger driverPass; // 驾照认证通过


@end

NS_ASSUME_NONNULL_END
