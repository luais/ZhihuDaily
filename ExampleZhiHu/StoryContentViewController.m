//
//  StoryContentViewController.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/15.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "StoryContentViewController.h"
#import "PreView.h"

@interface StoryContentViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *imaSourceLab;
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)PreView *preView;

@property(strong,nonatomic)StoryContentViewModel *viewModel;

@end

@implementation StoryContentViewController

- (instancetype)initWithViewModel:(StoryContentViewModel *)vm{
    self = [super init];
    if (self) {
        _viewModel = vm;
        [_viewModel addObserver:self forKeyPath:@"storyModel" options:NSKeyValueObservingOptionNew context:nil];
        [_viewModel getStoryContentWithStoryID:_viewModel.loadedStoryID];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载时图
    [self initSubView];
}

- (void)initSubView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-43)];
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    _headerView.clipsToBounds = YES;
    [self.view addSubview:_headerView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_imageView];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.numberOfLines = 0;
    [_headerView addSubview:_titleLab];
    
    _imaSourceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, kScreenWidth-20, 20)];
    _imaSourceLab.textAlignment = NSTextAlignmentRight;
    _imaSourceLab.font = [UIFont systemFontOfSize:12];
    _imaSourceLab.textColor = [UIColor whiteColor];
    [_headerView addSubview:_imaSourceLab];
    
    //tool
    UIView *toolBar = [[UIView alloc]initWithFrame:CGRectMake(0.f, kScreenHeight-43, kScreenWidth, 43)];
    //返回
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 43)];
    [backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:backBtn];
    //xia一个
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/5, 0, kScreenWidth/5, 43)];
    [nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:nextBtn];
    
    UIButton *voteBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5)*2, 0, kScreenWidth/5, 43)];
    [voteBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
    [toolBar addSubview:voteBtn];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5)*3, 0, kScreenWidth/5, 43)];
    [shareBtn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
    [toolBar addSubview:shareBtn];
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5)*4, 0, kScreenWidth/5, 43)];
    [commentBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
    [toolBar addSubview:commentBtn];
    
    [self.view addSubview:toolBar];
    
    _preView = [[PreView alloc]initWithFrame:kScreenBounds];
    [self.view addSubview:_preView];
    
}

//返回
- (void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//下一个
- (void)nextStoryAction:(id)sender{
    [_viewModel getNextStoryContent];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (-offSetY <= 80 && -offSetY >= 0) {
        _headerView.frame = CGRectMake(0, -40-offSetY/2, kScreenWidth, 260-offSetY/2);
        [_imaSourceLab setTop:240-offSetY/2];
        [_titleLab setBottom:_imaSourceLab.bottom -20];
        if (-offSetY > 40 && !_webView.scrollView.isDragging) {
            [self.viewModel getPreviousStoryContent];
        }
    }else if (-offSetY > 80){
        _webView.scrollView.contentOffset = CGPointMake(0, -80);
    }else if (offSetY <= 300){
        _headerView.frame = CGRectMake(0, -40-offSetY, kScreenWidth, 260);
    }
    if (offSetY +kScreenHeight > scrollView.contentSize.height + 160 && !_webView.scrollView.isDragging) {
        [self.viewModel getNextStoryContent];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"storyModel"]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.imageURLString]];
        CGSize size = [_viewModel.titleAttText boundingRectWithSize:CGSizeMake(kScreenWidth-30, 60) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        _titleLab.frame  =CGRectMake(15, _headerView.frame.size.height - 20 -size.height, kScreenWidth-30, size.height);
        _titleLab.attributedText = _viewModel.titleAttText;
        _imaSourceLab.text = _viewModel.imaSourceText;
        [_webView loadHTMLString:_viewModel.htmlStr baseURL:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_preView removeFromSuperview];
        });
        
    }
}
- (void)dealloc {
    [_viewModel removeObserver:self forKeyPath:@"storyModel"];
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
