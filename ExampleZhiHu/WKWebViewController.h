//
//  WKWebViewController.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/19.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryContentViewModel.h"

@interface WKWebViewController : UIViewController
- (instancetype)initWithViewModel:(StoryContentViewModel *)vm ;
@end
