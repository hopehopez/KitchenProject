//
//  MaterialCell.m
//  KitchenProject
//
//  Created by yhy on 16/1/27.
//  Copyright (c) 2016年 yhy. All rights reserved.
//

#import "MaterialCell.h"

@implementation MaterialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MaterialModel *)model{

    self.lb.text = model.materialName;
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"背景图"]];


}

@end
