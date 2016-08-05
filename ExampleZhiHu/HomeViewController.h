//
//  HomeViewController.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

@interface HomeViewController : UIViewController
- (instancetype)initWithViewModel:(HomeViewModel *)vm;
@end
