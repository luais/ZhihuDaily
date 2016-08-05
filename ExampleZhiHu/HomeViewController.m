//
//  HomeViewController.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "HomeViewController.h"
#import "StoryModel.h"
#import "HomeViewCell.h"
#import "SectionTitleView.h"
#import "StoryContentViewController.h"
#import "StoryContentViewModel.h"
#import "CarouseView.h"
#import "RefreshView.h"



#define kRowHeight 88.f
#define kSectionHeaderHeight 36.f

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,CarouseViewDelegate,UIScrollViewDelegate>
@property(nonatomic,weak)UITableView *mainTableView;
@property(nonatomic,weak)UIView *navBarBackgroundView;
@property(nonatomic,weak)UILabel *newsTodayLb;
@property(nonatomic,weak)CarouseView *carouseView;
@property(nonatomic,strong)HomeViewModel *viewmodel;
@property(nonatomic,weak)RefreshView *refreshView;
@end

@implementation HomeViewController

- (instancetype)initWithViewModel:(HomeViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewmodel = vm;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingLatestDaily:) name:@"LoadLatestDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingPreviousDaily:) name:@"LoadPreviousDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLatestDaily:) name:@"UpdateLatestDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainScrollViewToTop:) name:@"TapStatusBar" object:nil];
        [self.viewmodel getLatestStories];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 20.f, kScreenWidth, kScreenHeight-20.f)];
    tv.delegate = self;
    tv.dataSource = self;
    tv.rowHeight = kRowHeight;
    tv.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 200.f)];
    [self.view addSubview:tv];
    _mainTableView = tv;
    
    CarouseView *cv = [[CarouseView alloc] initWithFrame:CGRectMake(0.f, -40.f, kScreenWidth, 260.f)];
    cv.delegate = self;
    cv.clipsToBounds = YES;
    cv.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:cv];
    _carouseView = cv;
    
    //官方版高度没有64,所以加个高度56仿冒NavBar的View,56也配合每个section(36)过渡时的动画
    UIView *navBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 56.f)];
    navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];;
    [self.view addSubview:navBarBackgroundView];
    _navBarBackgroundView = navBarBackgroundView;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.attributedText = [[NSAttributedString alloc] initWithString:@"今日新闻" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [lab sizeToFit];
    [lab setCenter:CGPointMake(self.view.centerX, 38)];
    [self.view addSubview:lab];
    _newsTodayLb = lab;
    
    RefreshView *refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(_newsTodayLb.left-20.f, _newsTodayLb.centerY-10, 20.f, 20.f)];
    [self.view addSubview:refreshView];
    _refreshView = refreshView;
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(16.f, 28.f, 22.f, 22.f)];
    [menuBtn setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"HomeViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeViewCell"];
    [_mainTableView registerClass:[SectionTitleView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SectionTitleView class])];
}

- (void)showLeftMenu:(id)sender {
    AppDelegate *appdele = kAppdelegate;
    [appdele.mainVC showLeftMenuView];
}

- (void)setTopStoriesContent {
    [_carouseView setTopStories:self.viewmodel.top_stories];
}


- (void)loadingLatestDaily:(NSNotification *)noti {
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: 0];
    [_mainTableView insertSections:indexset withRowAnimation:UITableViewRowAnimationFade];
    [self setTopStoriesContent];
}

- (void)loadingPreviousDaily:(NSNotification *)noti {
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: [self.viewmodel numberOfSections]-1];
    [_mainTableView insertSections:indexset withRowAnimation:UITableViewRowAnimationFade];
}

- (void)updateLatestDaily:(NSNotification *)noti {
    if (![noti.userInfo[@"isNewDay"] boolValue]) {
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: 0];
        [_mainTableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
        [self setTopStoriesContent];
    }else {
        [_mainTableView reloadData];
        [self setTopStoriesContent];
    }
}

- (void)mainScrollViewToTop:(NSNotification *)noti {
    [_mainTableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - CarouseViewDelegate

- (void)didSelectItemWithTag:(NSInteger)tag {
    StoryModel *story = self.viewmodel.top_stories[tag-100];
    StoryContentViewModel* vm = [[StoryContentViewModel alloc] init];
    vm.loadedStoryID = story.storyID;
    vm.storiesID = _viewmodel.storiesID;
    StoryContentViewController *storyContentVC = [[StoryContentViewController alloc] initWithViewModel:vm];
    AppDelegate* appdele = kAppdelegate;
    [appdele.mainVC.navigationController pushViewController:storyContentVC animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_mainTableView]) {
        //下拉刷新和navBar的background渐变
        CGFloat offSetY = scrollView.contentOffset.y;
        if (offSetY<=0&&offSetY>=-80) {
            if (-offSetY<=40) {
                if(!_viewmodel.isLoading){
                    [_refreshView redrawFromProgress:-offSetY/40];
                }else{
                    [_refreshView redrawFromProgress:0];
                }
            }
            if (-offSetY>40&&-offSetY<=80&&!scrollView.isDragging&&!_viewmodel.isLoading) {
                [self.viewmodel updateLatestStories];
                [_refreshView startAnimation];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_refreshView stopAnimation];
                });
            }
            _carouseView.frame = CGRectMake(0, -40-offSetY/2, kScreenWidth, 260-offSetY/2);
            [_carouseView updateSubViewsOriginY:offSetY];
            _navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
        }else if(offSetY<-80){
            _mainTableView.contentOffset = CGPointMake(0.f, -80.f);
        }else if(offSetY <= 300) {
            [_refreshView redrawFromProgress:0];
            _carouseView.frame = CGRectMake(0, -40-offSetY, kScreenWidth, 260);
            _navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:offSetY/(220.f-56.f)];
        }
        
        //上拉刷新
        if (offSetY + kRowHeight > scrollView.contentSize.height - kScreenHeight) {
            if (!_viewmodel.isLoading) {
                [_viewmodel getPreviousStories];
            }
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewmodel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.viewmodel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HomeViewCell";
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StoryModel *story = [self.viewmodel storyAtIndexPath:indexPath];
    [cell setStoryModel:story];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryModel *story = [self.viewmodel storyAtIndexPath:indexPath];
    StoryContentViewModel* vm = [[StoryContentViewModel alloc] init];
    vm.loadedStoryID = story.storyID;
    vm.storiesID = _viewmodel.storiesID;
    StoryContentViewController *storyContentVC = [[StoryContentViewController alloc] initWithViewModel:vm];
    AppDelegate* appdele = kAppdelegate;
    [appdele.mainVC.navigationController pushViewController:storyContentVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return kSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    SectionTitleView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SectionTitleView class])];
    headerView.contentView.backgroundColor = kNavigationBarColor;
    headerView.textLabel.attributedText = [self.viewmodel titleForSection:section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        [_navBarBackgroundView setHeight:56.f];
        _newsTodayLb.alpha = 1.f;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        [_navBarBackgroundView setHeight:20.f];
        _newsTodayLb.alpha = 0.f;
    }
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
