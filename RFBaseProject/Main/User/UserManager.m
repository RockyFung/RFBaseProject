//
//  UserManager.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/12/3.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+ (UserManager* ) share{
    static UserManager *_userManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userManager = [[UserManager alloc]init];
    });
    return _userManager;
}

// 接档
- (UserInfoModel *)userModel{
    UserInfoModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:KUserModelFilePath];
    if (userModel) {
        NSLog(@"userModel 接档成功");
        return userModel;
    }else{
        NSLog(@"userModel 无存档，new model");
        return [[UserInfoModel alloc]init];
    }
}

// 存档
+ (BOOL)saveUserWithDict:(NSDictionary *)dict{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        UserInfoModel *model = [self share].userModel;
        [model mj_setKeyValues:dict];
        return [[self share] saveUserModel:model];
    }else{
        NSLog(@"不是字典类型")
        return NO;
    }
}

- (BOOL)saveUserModel:(UserInfoModel *)userModel{
    BOOL isOK = [NSKeyedArchiver archiveRootObject:userModel toFile:KUserModelFilePath];
    if (isOK) {
        NSLog(@"userModel 存档成功");
    }else{
        NSLog(@"userModel 存档失败");
    }
    return isOK;
}

// 删除存档
-(BOOL)removeFile{
    //创建文件管理对象
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:KUserModelFilePath];
    //进行逻辑判断
    if (!blHave) {
        NSLog(@"文件不存在");
        return NO;
    }else {
        //文件是否被删除
        BOOL blDele= [fileManager removeItemAtPath:KUserModelFilePath error:nil];
        //进行逻辑判断
        if (blDele) {
            NSLog(@"删除成功");
            return YES;
        }else{
            NSLog(@"删除失败");
            return NO;
        }
    }
}

@end


@implementation UserInfoModel
MJExtensionCodingImplementation
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"属性%@不存在",key);
}
@end
