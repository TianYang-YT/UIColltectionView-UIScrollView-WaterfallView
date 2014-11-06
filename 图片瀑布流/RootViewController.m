//
//  RootViewController.m
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
/**
 *  左侧侧栏按钮
 */
@property (nonatomic, weak) UIButton *leftBtn;
/**
 *  右侧侧栏按钮
 */
@property (nonatomic, weak) UIButton *rightBtn;
@end

@implementation RootViewController

- (NSArray *)titleArray { //等待子类重写此方法
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    
    [self creatrNavigationBar];
    
    [self configScrollView];
}

- (void)creatrNavigationBar {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 84)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    //橘色背景
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    navigationView.backgroundColor = kColor(241, 86, 11);
    [self.bgView addSubview:navigationView];
    self.navigationView = navigationView;
    
    //99艺术网logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center_textIcon"]];
    logoImageView.frame = CGRectMake(kWidth / 2 - 70, 30, 88, 19);
    [self.navigationView addSubview:logoImageView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2 + 22, 29, 50, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(10, 20, 68, 40)];
    [leftBtn setImage:[UIImage imageNamed:@"center_leftIcon"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(kWidth - 50, 25, 50, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:rightBtn];
}

- (void)configScrollView {
    TitleScrollView *scrollView = [[TitleScrollView alloc] initWithFrame:CGRectMake(10, 64, kWidth - 20, 20)];
    scrollView.clickDelegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

#pragma mark - TitleScrollViewDelegate
- (void)titleScrollView:(TitleScrollView *)titleScrollView didClickButton:(UIButton *)button {
    
}

@end
