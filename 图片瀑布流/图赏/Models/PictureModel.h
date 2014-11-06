//
//  PictureModel.h
//  99Art
//
//  Created by 杨天 on 14-11-1.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject
@property (nonatomic, copy) NSString *id;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  作者
 */
@property (nonatomic, copy) NSString *author;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *pubtime;
/**
 *  喜欢数
 */
@property (nonatomic, copy) NSString *praised;
/**
 *  评论数
 */
@property (nonatomic, copy) NSString *commentcount;
/**
 *  大图地址
 */
@property (nonatomic, copy) NSString *imgurl;
/**
 *  大图宽度
 */
@property (nonatomic, copy) NSNumber *imgurl_width;
/**
 *  大图高度
 */
@property (nonatomic, copy) NSNumber *imgurl_height;
/**
 *  cell小图地址
 */
@property (nonatomic, copy) NSString *coverimg;
/**
 *  cell小图宽度
 */
@property (nonatomic, copy) NSNumber *coverimgwidth;
/**
 *  cell小图高度
 */
@property (nonatomic, copy) NSString *coverimgheight;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

- (CGFloat)cellHeightWithImageHeight:(NSString *)imageHeight andImageWidth:(NSNumber *)imageWidth;
@end
