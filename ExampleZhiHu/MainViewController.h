//
//  MainViewController.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "LeftMenuViewController.h"

@interface MainViewController : UIViewController

- (instancetype)initWithLeftMenuViewController:(LeftMenuViewController*) menuVC  andHomeViewController:(HomeViewController*)homeVC;
- (void)showMainView;
- (void)showLeftMenuView;
@end
