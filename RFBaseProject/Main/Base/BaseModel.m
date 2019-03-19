//
//  BaseModel.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/23.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
// 处理不存在的key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

// 处理空的value
- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"%@:[nilValue]",key);
}

@end
