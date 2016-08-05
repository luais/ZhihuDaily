//
//  StoryModel.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/10.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self ) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"storyID"];
    }
    if ([key isEqualToString:@"multipic"]) {
        [self setValue:value forKey:@"isMultipic"];
    }
}

@end
