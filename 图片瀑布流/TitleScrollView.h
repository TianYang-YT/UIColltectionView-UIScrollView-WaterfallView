//
//  TitleScrollView.h
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleScrollView;

@protocol TitleScrollViewDelegate <NSObject>

- (void)titleScrollView:(TitleScrollView *)titleScrollView didClickButton:(UIButton *)button;

@end

@interface TitleScrollView : UIScrollView

/**
 *  存储被选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, strong) NSArray *btnTitleArray;
/**
 *  背景view(因动画而加)
 */
@property (nonatomic, weak) UIView *orangeView;

@property (nonatomic, weak) id <TitleScrollViewDelegate> clickDelegate;
@end
