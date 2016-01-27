//
//  ProcessCell.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/27.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "ProcessCell.h"

@implementation ProcessCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ProcessModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"背景图"]];
    self.numLabel.text = model.order_id;
    self.descriptionLabel.text = model.describe;
}

@end
