//
//  PictureModel.m
//  99Art
//
//  Created by 杨天 on 14-11-1.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel
#define kImageWidth 150

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (CGFloat)cellHeightWithImageHeight:(NSString *)imageHeight andImageWidth:(NSNumber *)imageWidth {
    CGFloat width = kImageWidth;
    CGFloat height = width * [imageHeight doubleValue] / [imageWidth doubleValue];
    return height;
}
@end
