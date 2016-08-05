//
//  CarouseView.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/13.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouseViewDelegate <NSObject>

- (void)didSelectItemWithTag:(NSInteger)tag;

@end
/**
 *  滚动图
 */
@interface CarouseView : UIView

@property(strong,nonatomic)NSArray *topStories;
@property(weak,nonatomic) id<CarouseViewDelegate> delegate;

- (void)updateSubViewsOriginY:(CGFloat)value;

@end
