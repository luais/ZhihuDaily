//
//  MainViewController.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "MainViewController.h"
//打开抽屉动画参数初始值
#define AnimateDuration             0.2
#define MainViewOriginXFromValue    0
#define MainViewOriginXEndValue     kScreenWidth*0.6
#define MainViewMoveXMaxValue       ABS(MainViewOriginXEndValue - MainViewOriginXFromValue)
#define MainViewScaleYFromValue     1
#define MainViewScaleYEndValue      1
#define MainViewScaleMaxValue       ABS(MainViewScaleYEndValue - MainViewScaleYFromValue)
#define LeftViewOriginXFromValue    -kScreenWidth*0.6
#define LeftViewOriginXEndValue     0
#define LeftViewMoveXMaxValue       ABS(LeftViewOriginXEndValue - LeftViewOriginXFromValue)
#define LeftViewScaleFromValue      1
#define LeftViewScaleEndValue       1
#define LeftViewScaleMaxValue       ABS(LeftViewScaleEndValue - LeftViewScaleFromValue)

@interface MainViewController ()

@property(strong,nonatomic) HomeViewController *homeViewController;
@property(strong,nonatomic) LeftMenuViewController *leftMenuViewController;
@property(assign,nonatomic) CGFloat distance;
@property(strong,nonatomic) UIView *leftMenuView;
@property(strong,nonatomic) UIView *mainView;
@property(strong,nonatomic) UITapGestureRecognizer *tap;

@end

@implementation MainViewController

- (instancetype)initWithLeftMenuViewController:(LeftMenuViewController *)menuVC andHomeViewController:(HomeViewController *)homeVC {
    self = [super init];
    if (self) {
        self.homeViewController = homeVC;
        self.leftMenuViewController = menuVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _distance = MainViewOriginXFromValue;
    
    _leftMenuView = _leftMenuViewController.view;
    _leftMenuView.frame = kScreenBounds;
    _leftMenuView.transform =CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    [self.view addSubview:_leftMenuView];
    
    _mainView = [[UIView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_mainView];
    [_mainView addSubview:_homeViewController.view];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_mainView addGestureRecognizer:panGesture];
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
}

- (void)tap:(UITapGestureRecognizer *)recongizer {
    [self showMainView];
}

- (void)pan:(UIPanGestureRecognizer *)recongnizer {
    
    CGFloat moveX = [recongnizer translationInView:self.view].x;
    CGFloat truedistance = _distance + moveX;
    CGFloat percent = truedistance/MainViewMoveXMaxValue;
    if (truedistance >= 0 && truedistance <= MainViewMoveXMaxValue) {
        _mainView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYFromValue-MainViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue+truedistance, 0));
        _leftMenuView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue+LeftViewMoveXMaxValue*percent, 0));
    }
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (truedistance <= MainViewMoveXMaxValue/2) {
            [self showMainView];
        }else{
            [self showLeftMenuView];
        }
    }
    
}

- (void)showMainView {
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _mainView.transform = CGAffineTransformIdentity;
        _leftMenuView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXFromValue;
        [_mainView removeGestureRecognizer:_tap];
    }];
}

- (void)showLeftMenuView {
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _mainView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYEndValue), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXEndValue, 0));
        _leftMenuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXEndValue;
        [_mainView addGestureRecognizer:_tap];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
