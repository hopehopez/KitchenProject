//
//  MaterialCell.h
//  KitchenProject
//
//  Created by yhy on 16/1/27.
//  Copyright (c) 2016年 yhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"
@interface MaterialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (nonatomic,strong)MaterialModel *model;
@end
