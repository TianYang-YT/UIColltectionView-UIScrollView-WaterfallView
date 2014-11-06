//
//  YTCollectionScrollView.m
//  99Art
//
//  Created by 杨天 on 14-11-1.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "YTCollectionScrollView.h"
#import "MyCollectionViewLayout.h"
#import "PictureCell.h"
#import "PictureModel.h"

@interface YTCollectionScrollView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyCollectionViewLayoutDelegete>
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation YTCollectionScrollView

- (NSMutableDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
    }
    return self;
}

- (void)createCollectionView:(NSInteger)count {
    for (int i = 0; i < count; i++) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 0;
        
//        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        MyCollectionViewLayout *layout = [[MyCollectionViewLayout alloc] init];
        layout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(i * kWidth, 0, kWidth, self.frame.size.height) collectionViewLayout:layout];
        collectionView.tag = i + 1;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.alwaysBounceVertical = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[PictureCell class] forCellWithReuseIdentifier:@"Picture"];
        [self addSubview:collectionView];
    }
    self.contentSize = CGSizeMake(count * kWidth, self.frame.size.height);
}

- (void)setDataArray:(NSArray *)dataArray withPage:(NSInteger)page {
    [self.dataDict setObject:dataArray forKey:@(page)];
    UITableView *tableView = (UITableView *)[self viewWithTag:page];
    [tableView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MyCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureModel *model = _dataDict[@(collectionView.tag)][indexPath.row];
    return [model cellHeightWithImageHeight:model.coverimgheight andImageWidth:model.coverimgwidth] + 25;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    PictureModel *model = _dataDict[@(collectionView.tag)][indexPath.row];
//    
//    return CGSizeMake(160, [model cellHeightWithImageHeight:model.coverimgheight andImageWidth:model.coverimgwidth] + 25);
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataDict[@(collectionView.tag)] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Picture";
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _dataDict[@(collectionView.tag)][indexPath.row];
    return cell;
}
@end
