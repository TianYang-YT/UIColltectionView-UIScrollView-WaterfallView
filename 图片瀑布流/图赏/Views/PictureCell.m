//
//  PictureCell.m
//  99Art
//
//  Created by 杨天 on 14-11-1.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "PictureCell.h"
#import "PictureModel.h"

@interface PictureCell ()
@property (nonatomic, weak) UIImageView *picture;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UILabel *commentCount;
@property (nonatomic, weak) UILabel *likeCount;
@end

@implementation PictureCell
#define kLabelFont [UIFont systemFontOfSize:12];

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = kColor(242, 242, 242);
        
        UIImageView *picture = [[UIImageView alloc] init];
        [self.contentView addSubview:picture];
        self.picture = picture;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = kColor(242, 242, 242);
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        likeCount.font = kLabelFont;
        [bgView addSubview:likeCount];
        self.likeCount = likeCount;
        
        UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
        likeLabel.font = kLabelFont;
        likeLabel.text = @"赞";
        [bgView addSubview:likeLabel];
        
        UILabel *commentCount = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 20, 20)];
        commentCount.font = kLabelFont;
        [bgView addSubview:commentCount];
        self.commentCount = commentCount;
        
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 30, 20)];
        commentLabel.font = kLabelFont;
        commentLabel.text = @"评论";
        [bgView addSubview:commentLabel];
    }
    return self;
}

- (void)setModel:(PictureModel *)model {
    _model = model;
    
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    [self.likeCount setText:model.praised];
    [self.commentCount setText:model.commentcount];
    
    [self settingFrame:model];
}

- (void)settingFrame:(PictureModel *)model {
    CGFloat height = [model cellHeightWithImageHeight:model.coverimgheight andImageWidth:model.coverimgwidth];
    [self.picture setFrame:CGRectMake(7, 5, 150, height)];
    [self.bgView setFrame:CGRectMake(10, CGRectGetMaxY(self.picture.frame), self.picture.frame.size.width, 20)];
}

@end
