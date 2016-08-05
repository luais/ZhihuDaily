//
//  RefreshView.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/15.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView
- (void)redrawFromProgress:(CGFloat)progress;
- (void)startAnimation;
- (void)stopAnimation;
@end
