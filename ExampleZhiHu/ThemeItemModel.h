//
//  ThemeItemModel.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/18.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeItemModel : NSObject
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSNumber *themeID;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
