//
//  RootViewController.h
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleScrollView.h"

@interface RootViewController : UIViewController <TitleScrollViewDelegate>
{
    //向外暴露 标题数组
    NSArray *_titleArray;
}
/**
 *  自定义导航栏
 */
@property (nonatomic, weak) UIView *navigationView;
/**
 *  导航栏右侧标题
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  最底层view (上面有导航栏和scrollView)
 */
@property (nonatomic, weak) UIView *bgView;
/**
 *  小标题scrollView
 */
@property (nonatomic, weak) TitleScrollView *scrollView;
/**
 *  等待子类重写此方法
 */
- (NSArray *)titleArray;
@end
