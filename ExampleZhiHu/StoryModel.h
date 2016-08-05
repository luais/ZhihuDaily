//
//  StoryModel.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/10.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModel : NSObject

@property(copy,nonatomic)NSString *title;   //日报标题
@property(copy,nonatomic)NSNumber *storyID; //日报id
@property(strong,nonatomic)NSArray *images; //图片url数组
@property(assign,nonatomic)BOOL isMultipic; //是否多图
@property(strong,nonatomic)NSNumber *type;  //日报类型
@property(copy,nonatomic)NSString *image;   //图片


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
