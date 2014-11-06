//
//  MyCollectionViewLayout.h
//  UICollectionViewDemo
//
//  Created by Visitor on 14-10-17.
//  Copyright (c) 2014年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCollectionViewLayout;

@protocol MyCollectionViewLayoutDelegete <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MyCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MyCollectionViewLayout : UICollectionViewLayout
//一行有多少个Item
@property (nonatomic,assign) NSUInteger columnCount;
//一个item的宽度
@property (nonatomic,assign) CGFloat itemWidth;
//设置insets
@property (nonatomic,assign) UIEdgeInsets sectionInset;
@property (nonatomic,weak)__weak id <MyCollectionViewLayoutDelegete> delegate;
//item的总个数
@property (nonatomic,assign) NSInteger itemCount;
//间隔
@property (nonatomic,assign) CGFloat interitemSpacing;
//高度
@property (nonatomic,strong) NSMutableArray *columnHeights; // height for each column
//item属性
@property (nonatomic,strong) NSMutableArray *itemAttributes; // attributes for each item
@end
