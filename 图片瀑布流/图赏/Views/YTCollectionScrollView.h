//
//  YTCollectionScrollView.h
//  99Art
//
//  Created by 杨天 on 14-11-1.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTCollectionScrollView : UIScrollView
/**
 *  按照标题数量创建collectionView;
 */
- (void)createCollectionView:(NSInteger)count;
- (void)setDataArray:(NSArray *)dataArray withPage:(NSInteger)page;
@end
