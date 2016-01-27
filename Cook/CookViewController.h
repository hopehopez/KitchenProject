//
//  CookViewController.h
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *searchClick;
- (IBAction)searchClick:(id)sender;

@end
