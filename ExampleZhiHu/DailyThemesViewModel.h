//
//  DailyThemesViewModel.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/18.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyThemesViewModel : NSObject

@property(strong,nonatomic) NSMutableArray *stories;
@property(strong,nonatomic) NSString *imageURLStr;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *editors;

- (void)getDailyThemesDataWithThemeID:(NSNumber *)themeID;
@end
