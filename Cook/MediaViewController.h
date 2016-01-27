//
//  MediaViewController.h
//  KitchenProject
//
//  Created by 张树青 on 16/1/26.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *playerView;

@property (weak, nonatomic) IBOutlet UIImageView *playerBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *txtField;

@property (strong, nonatomic) NSDictionary *dict;


- (IBAction)backClick:(id)sender;
- (IBAction)sendBtn:(id)sender;

@end
