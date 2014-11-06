//
//  TitleScrollView.m
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "TitleScrollView.h"

@interface TitleScrollView ()
@end

@implementation TitleScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setBtnTitleArray:(NSArray *)btnTitleArray {
    if (_btnTitleArray != btnTitleArray) {
        _btnTitleArray = nil;
        _btnTitleArray = btnTitleArray;
    }
    CGFloat titleBtnWidth = 0;
    if (btnTitleArray.count > 3) {
        titleBtnWidth = 35;
    }else {
        titleBtnWidth = 70;
    }
    CGFloat space = (kWidth - btnTitleArray.count * titleBtnWidth) / (btnTitleArray.count + 1);
    for (int i = 0; i < btnTitleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(space + i * (titleBtnWidth + space) - 10, 2, titleBtnWidth, self.frame.size.height - 4);
        [btn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        [btn setTag:i + 1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [btn setBackgroundImage:[UIImage imageNamed:@"newCountBg"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            [self titleBtnClick:btn];
            UIView *orangeView = [[UIView alloc] initWithFrame:btn.frame];
            orangeView.backgroundColor = kColor(241, 86, 11);
            orangeView.layer.cornerRadius = 2;
            [self addSubview:orangeView];
            [self sendSubviewToBack:orangeView];
            self.orangeView = orangeView;
        }
    }
    self.contentSize = CGSizeMake((titleBtnWidth + space) * btnTitleArray.count, self.frame.size.height);
}

- (void)titleBtnClick:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        self.selectedBtn.selected = NO;
        self.orangeView.frame = btn.frame;
    } completion:^(BOOL finished) {
        btn.selected = YES;
        self.selectedBtn = btn;
    }];
    if ([_clickDelegate respondsToSelector:@selector(titleScrollView:didClickButton:)]) {
        [_clickDelegate titleScrollView:self didClickButton:btn];
    }
}

@end