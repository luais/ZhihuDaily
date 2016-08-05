//
//  StoryContentViewModel.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/15.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "StoryContentViewModel.h"

@implementation StoryContentViewModel

- (NSString*)imageURLString{
    return _storyModel.image;
}

- (NSAttributedString *)titleAttText{
    return [[NSAttributedString alloc]initWithString:_storyModel.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSString *)imaSourceText{
    return [NSString stringWithFormat:@"图片:%@",_storyModel.image_source];
}

- (NSString *)htmlStr {
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_storyModel.css[0],_storyModel.body];
}

- (NSString *)share_URL{
    return _storyModel.share_url;
}

- (NSNumber *)storyType{
    return _storyModel.type;
}

- (NSArray *)recommenders{
    return _storyModel.recommenders;
}

-(void)getStoryContentWithStoryID:(NSNumber *)storyID{
    
    [HttpOperation getRequestWithURL:[NSString stringWithFormat:@"news/%@",[storyID stringValue]] parameters:nil success:^(id responseObject) {
        NSDictionary *jsonDic = (NSDictionary*)responseObject;
        StoryContentModel *model = [[StoryContentModel alloc] initWithDictionary:jsonDic];
        [self setValue:model forKey:@"storyModel"];
        _loadedStoryID = storyID;
    } failure:nil];
}

- (void)getPreviousStoryContent{
    NSInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (--index >= 0) {
        NSNumber *nextStoryID = [_storiesID objectAtIndex:index];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

- (void)getNextStoryContent{
    NSUInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (++index < _storiesID.count) {
        NSNumber *nextStoryID = [_storiesID objectAtIndex:index];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

























@end
