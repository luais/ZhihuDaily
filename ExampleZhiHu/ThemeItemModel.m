//
//  ThemeItemModel.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/18.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "ThemeItemModel.h"

@implementation ThemeItemModel
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"themeID"];
    }
}

@end
