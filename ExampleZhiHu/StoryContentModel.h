//
//  StoryContentModel.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/15.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryContentModel : NSObject

@property (copy,nonatomic  ) NSString *body;
@property (copy,nonatomic  ) NSString *image_source;
@property (copy,nonatomic  ) NSString *title;
@property (copy,nonatomic  ) NSString *image;
@property (copy,nonatomic  ) NSNumber *storyID;
@property (copy,nonatomic  ) NSArray  *css;
@property (copy,nonatomic  ) NSString *share_url;
@property (strong,nonatomic) NSArray  *recommenders;
@property (strong,nonatomic) NSNumber *type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
