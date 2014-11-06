//
//  MyCollectionViewLayout.m
//  UICollectionViewDemo
//
//  Created by Visitor on 14-10-17.
//  Copyright (c) 2014年 Visitor. All rights reserved.
//

#import "MyCollectionViewLayout.h"

#define COLUMNCOUNT 2
#define ITEMWIDTH 160.0f

@implementation MyCollectionViewLayout


- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _columnCount = COLUMNCOUNT;
    _itemWidth = ITEMWIDTH;
    _sectionInset = UIEdgeInsetsZero;
}

//准备(更新)布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    _itemCount = [[self collectionView] numberOfItemsInSection:0];
    
    CGFloat width = self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right;
    //计算每个Item之间的间隔(不包括外部的间隔)
    _interitemSpacing = floorf((width - _columnCount * _itemWidth) / (_columnCount - 1));
    
    //存储布局属性  一个item对应一个布局属性
    _itemAttributes = [NSMutableArray arrayWithCapacity:_itemCount];
    //存储高度
    _columnHeights = [NSMutableArray arrayWithCapacity:_columnCount];
    
    for (NSInteger i = 0; i < _columnCount; i++)
    {
        NSLog(@"sectionInset.top = %f",_sectionInset.top);
        [_columnHeights addObject:@(_sectionInset.top)];
    }
    
    for (NSInteger i = 0; i < _itemCount; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //返回每一个item的高度
        CGFloat itemHeight = [_delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];

        
        NSUInteger columnIndex = [self shortestColumnIndex];
        
        CGFloat xOffset = _sectionInset.left + (_itemWidth + _interitemSpacing) * columnIndex;
        //5
        CGFloat yOffset = [(_columnHeights[columnIndex]) floatValue];
        
        //布局对应的属性
        UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, self.itemWidth, itemHeight);
        [_itemAttributes addObject:attributes];
        _columnHeights[columnIndex] = @(yOffset + itemHeight + _interitemSpacing);
    }
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize
{
    if (self.itemCount == 0)
    {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.frame.size;
    NSUInteger columnIndex = [self longestColumnIndex];
    
    CGFloat height = [self.columnHeights[columnIndex] floatValue];
    contentSize.height = height - self.interitemSpacing + self.sectionInset.bottom;
    return contentSize;
}

//返给每一个item一个布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return _itemAttributes[path.item];
}

//返回一组布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

#pragma mark - Private Methods

- (NSUInteger)shortestColumnIndex
{
    //想在block中修改基本数据类型，前面用__block
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;

    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}

- (NSUInteger)longestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    return index;
}

@end
