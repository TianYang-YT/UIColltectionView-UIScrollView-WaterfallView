//
//  DEFINE.h
//  99Art
//
//  Created by 杨天 on 14-10-29.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#ifndef _9Art_DEFINE_h
#define _9Art_DEFINE_h

//屏幕高度
#define kHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define kWidth [[UIScreen mainScreen] bounds].size.width
//快速生成颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)\

#pragma mark - 一级页面
//专题
#define kImageURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=7&stamp=1414546287"
//全部
#define kAllURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=8&stamp=1414546287"
//油画
#define kOilPaintingURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=9&stamp=1414546287"
//书画
#define kPaintingURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=10&stamp=1414546287"
//摄影
#define kShootURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=12&stamp=1414546287"
//水墨
#define kInkPaintingURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=13&stamp=1414833419"
//雕塑
#define kSculptureURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=14&stamp=1414833419"
//版画
#define kPrintmakingURL @"http://news.99ys.com/index.php?m=interface&c=main&a=newslist&page=1&id=15&stamp=1414833419"

#endif
