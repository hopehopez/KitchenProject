//
//  SearchViewController.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/27.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate>{
    //记录当前处于打开状态的 section
    int _currentSection;
}

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //_currentSection = -1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self addTableViewHeaderView];
    
    [self setTableViewBackImageView];
    
    [self hideTableViewExtraLine];
}

#pragma mark - 隐藏表格中多余的行
- (void)hideTableViewExtraLine{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
}

#pragma mark - 设置tableView背景图
- (void)setTableViewBackImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_tableView.bounds];
    imageView.image = [UIImage imageNamed:@"背景图"];
    [_tableView setBackgroundView:imageView];
}

#pragma mark - 为tableView添加头视图
- (void)addTableViewHeaderView{
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    grayView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = grayView;
}

#pragma mark - data Source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

#pragma mark - delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == _currentSection) {
        return 1;
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    imageView.image = [UIImage imageNamed:@"搜索-类别筛选"];
    
    //添加文字
    NSArray *array=@[@"中华菜系",@"口味分类",@"人群分类",@"烹饪分类",@"功效分类"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 7, 100, 30)];
    label.text = array[section];
    label.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:label];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    imageView.tag = 100 + section;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    return imageView;
}
//tap手势 方法
- (void)tapClick:(UIGestureRecognizer *)tap{
    _currentSection = (int)tap.view.tag - 100;
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
