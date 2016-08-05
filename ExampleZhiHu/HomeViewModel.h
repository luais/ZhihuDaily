//
//  HomeViewModel.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/10.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoryModel;
@interface HomeViewModel : NSObject

@property(strong,readonly,nonatomic)NSMutableArray*daysDataList;
@property(strong,readonly,nonatomic)NSMutableArray *top_stories;
@property(assign,readonly,nonatomic)BOOL isLoading;
@property(strong,readonly,nonatomic)NSMutableArray *storiesID;

- (void)getLatestStories;
- (void)getPreviousStories;
- (void)updateLatestStories;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSAttributedString *)titleForSection:(NSInteger)section;
- (StoryModel *)storyAtIndexPath:(NSIndexPath *)indexPath;

@end
