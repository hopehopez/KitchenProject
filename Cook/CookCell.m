//
//  CookCell.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "CookCell.h"

@implementation CookCell

- (void)awakeFromNib {
    // Initialization code
    //左侧播放按钮手势
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapClick:)];
    self.leftPlayer.userInteractionEnabled = YES;
    [self.leftPlayer addGestureRecognizer:leftTap];
    
    //中间播放按钮手势
    UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleTapClick:)];
    self.middlePlayer.userInteractionEnabled = YES;
    [self.middlePlayer addGestureRecognizer:middleTap];
    
    //右侧播放按钮手势
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapClick:)];
    self.rightPlayer.userInteractionEnabled = YES;
    [self.rightPlayer addGestureRecognizer:rightTap];
    
    
}

- (void)leftTapClick:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaViewController" object:self.leftDicttionary userInfo:nil];
}
- (void)middleTapClick:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaViewController" object:self.middleDictionary userInfo:nil];
}
- (void)rightTapClick:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaViewController" object:self.rightDictionary userInfo:nil];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写set方法
- (void)setModel:(CookModel *)model{
    self.titleLabel.text = model.name;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.imageFilename] placeholderImage:[UIImage imageNamed:@"背景图"] options:SDWebImageRefreshCached];
   
    //解析左侧图片数据
    NSDictionary *leftDict = [model.vegetableList firstObject];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftDict[@"imagePathThumbnails"]] placeholderImage:[UIImage imageNamed:@"背景图"] options:SDWebImageRefreshCached];
    self.leftLabel.text = leftDict[@"name"];
    
    //解析右侧图片数据
    NSDictionary *middleDict = model.vegetableList[1];
    [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleDict[@"imagePathThumbnails"]] placeholderImage:[UIImage imageNamed:@"背景图"] options:SDWebImageRefreshCached];
    self.middleLabel.text = middleDict[@"name"];
    
    //解析右侧图片
    NSDictionary *rightDict = model.vegetableList[2];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightDict[@"imagePathThumbnails"]] placeholderImage:[UIImage imageNamed:@"背景图"] options:SDWebImageRefreshCached];
    self.rightLabel.text = rightDict[@"name"];
    
    self.leftDicttionary = leftDict;
    self.middleDictionary = middleDict;
    self.rightDictionary = rightDict;
    
}

@end
