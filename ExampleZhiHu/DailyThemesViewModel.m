//
//  DailyThemesViewModel.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/18.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "DailyThemesViewModel.h"
#import "StoryModel.h"

@implementation DailyThemesViewModel

- (void)getDailyThemesDataWithThemeID:(NSNumber *)themeID{
    [HttpOperation getRequestWithURL:[NSString stringWithFormat:@"theme/%@",themeID] parameters:nil success:^(id responseObject) {
        NSDictionary *jsonDic  = (NSDictionary *)responseObject;
        NSArray *storiesArr = jsonDic[@"stories"];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic in storiesArr) {
            StoryModel *model = [[StoryModel alloc]initWithDictionary:dic];
            [tempArr addObject:model];
        }
        [self setValue:tempArr forKey:@"stories"];
        [self setValue:jsonDic[@"background"] forKey:@"imageURLStr"];
        [self setValue:jsonDic[@"name"] forKey:@"name"];
        [self setValue:jsonDic[@"editors"] forKey:@"editors"];
    } failure:nil];
}

@end
