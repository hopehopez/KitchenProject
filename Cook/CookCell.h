//
//  CookCell.h
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookModel.h"
@interface CookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftPlayer;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middlePlayer;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightPlayer;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (strong, nonatomic) NSDictionary *leftDicttionary;
@property (nonatomic, strong) NSDictionary *middleDictionary;
@property (nonatomic, strong) NSDictionary *rightDictionary;

@property (nonatomic, strong) CookModel *model;
//在自定义cell中声明数据模型


@end
