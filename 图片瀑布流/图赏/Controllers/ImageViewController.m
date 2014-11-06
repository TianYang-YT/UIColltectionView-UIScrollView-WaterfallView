//
//  ImageViewController.m
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "ImageViewController.h"
#import "YTCollectionScrollView.h"
#import "PictureModel.h"

@interface ImageViewController () <UIScrollViewDelegate>
/**
 *  普通cell数据源
 */
@property (nonatomic, strong) NSArray *dataArray;
/**
 *  多collection的scrollView
 */
@property (nonatomic, weak) YTCollectionScrollView *collectScrollView;
/**
 *  存储已经被请求的地址
 */
@property (nonatomic, strong) NSMutableArray *requestedArray;
/**
 *  新闻页面所有请求地址
 */
@property (nonatomic, strong) NSArray *urlStringArray;
/**
 *  告诉YTCollectionScrollView请求哪个collectionView 根据偏移量算出 初始化为1
 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation ImageViewController
- (NSArray *)urlStringArray {
    if (!_urlStringArray) {
        _urlStringArray = @[kAllURL, kOilPaintingURL, kPaintingURL, kShootURL, kInkPaintingURL, kSculptureURL, kPrintmakingURL];
    }
    return _urlStringArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"全部", @"油画", @"书画", @"摄影", @"水墨", @"雕塑", @"版画"];
    }
    return _titleArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _requestedArray = [NSMutableArray array];
    self.titleLabel.text = @"图赏";
    _page = 1;
    //布局titlescrollView
    self.scrollView.btnTitleArray = self.titleArray;
    [self configCollectionScrollView];
    [self loadData:kAllURL];
}

- (void)configCollectionScrollView {
    YTCollectionScrollView *collectScrollView = [[YTCollectionScrollView alloc] initWithFrame:CGRectMake(0, 84, kWidth, kHeight - 84)];
    collectScrollView.delegate = self;
    [self.view addSubview:collectScrollView];
    self.collectScrollView = collectScrollView;
    [self.collectScrollView createCollectionView:self.titleArray.count];
}

- (void)loadData:(NSString *)urlString {
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    [[YTHttpManager shareManager] netStatus:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [YTHttpManager GET:urlString finished:^(AFHTTPRequestOperation *operation, id responseObj) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in dic[@"articles"]) {
                    [tempArray addObject:[PictureModel modelWithDict:dict]];
                }
                _dataArray = tempArray;
                //将数据源一起传过去
                [self.collectScrollView setDataArray:_dataArray withPage:_page];
                
                [_requestedArray addObject:urlString];
                [SVProgressHUD dismiss];
            } failed:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络状态差,再试一次!"];
            }];
        }else {
            [SVProgressHUD showErrorWithStatus:@"亲,没有检测到网络哦!"];
        }
    }];
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //根据偏移量找到按钮并移动后面的背景色
    [self setOrangeToLocation];
    
    [self requestOtherData];
}

- (void)setOrangeToLocation {
    CGFloat offsetX = self.collectScrollView.contentOffset.x;
    self.scrollView.selectedBtn.selected = NO;
    UIButton *btn = (UIButton *)[self.scrollView viewWithTag:(int)(offsetX / 320) + 1];
    btn.selected = YES;
    self.scrollView.selectedBtn = btn;
    [UIView animateWithDuration:0.15 animations:^{
        self.scrollView.orangeView.frame = btn.frame;
    }];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //动画执行完成后调用
    [self requestOtherData];
}

- (void)requestOtherData {
    CGFloat offsetX = self.collectScrollView.contentOffset.x;
    _page = (int)(offsetX / kWidth);
    if (_page < 1) {
        return;
    }
    NSString *urlString = self.urlStringArray[_page];
    _page++;
    for (NSString *str in _requestedArray) {
        if ([str isEqualToString:urlString]) {
            return;
        }
    }
    [self loadData:urlString];
}

#pragma mark - TitleScrollViewDelegate
- (void)titleScrollView:(TitleScrollView *)titleScrollView didClickButton:(UIButton *)button {
    [self.collectScrollView setContentOffset:CGPointMake((button.tag - 1) * kWidth, 0) animated:YES];
}
@end






