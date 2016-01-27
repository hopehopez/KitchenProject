//
//  MediaViewController.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/26.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "MediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MaterialModel.h"
#import "MaterialCell.h"
#import "ProcessModel.h"
#import "ProcessCell.h"
@interface MediaViewController () <UITableViewDataSource, UITableViewDelegate>{
    //声明视频播放器成员变量
    //MPMoviePlayerController *_playerController;
    MPMoviePlayerViewController *_playerController;
    
    //声明加载指示器
    UIActivityIndicatorView *_activityView;
    
    //记录当前段闭合展开的状态
    int open[5];
    
    //声明材料数据源数组
    NSMutableArray *_metarilArray;
    
    //声明步骤数据源数组
    NSMutableArray *_processArray;
}

@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _metarilArray = [NSMutableArray array];
    _processArray = [NSMutableArray array];
    
    [self keyBoardNotifications];
    
    [self setTitlePlayerView];
    
    [self addTapOnPlayerButton];
    
    [self moviePlayerNotifications];
    
    [self registerMaterialCell];

    [self loadMatirialRequest];
    
    [self registerProcessCell];
    
    [self loadProcessRequest];
}

#pragma mark - 请求制作过程的网络数据
- (void)loadProcessRequest{
    NSString *strUrl = [NSString stringWithFormat:URL_VEGETABLE_DETAIL, self.dict[@"vegetable_id"], 2];
    [AFHttpRequest GET:strUrl andSuccess:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"data"];
        for (NSDictionary *dict1 in array) {
            ProcessModel *model = [[ProcessModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_processArray addObject:model];
        }
        
        [_tableView reloadData];
        
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@", failedReason);
    }];
}

#pragma mark - 注册过程自定制celll
- (void)registerProcessCell{
    UINib *nib = [UINib nibWithNibName:@"ProcessCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"ProcessCell"];
}

#pragma mark - 注册材料自定制cell
- (void)registerMaterialCell{
    UINib *nib = [UINib nibWithNibName:@"MaterialCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"MaterialCell"];
}

#pragma mark - 请求制作材料
- (void)loadMatirialRequest{
    NSString *strUrl = [NSString stringWithFormat:URL_VEGETABLE_DETAIL, self.dict[@"vegetable_id"], 1];
    [AFHttpRequest GET:strUrl andSuccess:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = dict[@"data"];
        for (int i = 0; i<array.count; i++) {
            NSDictionary *dataDictionary = array[i];
            MaterialModel *material =[[MaterialModel alloc] init];
            [material setValuesForKeysWithDictionary:dataDictionary];
            [_metarilArray addObject:material];
        }
        [self.tableView reloadData];
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@", failedReason);
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //停止视频播放
    [_playerController.moviePlayer stop];
}

#pragma mark - 监听视频播放器的通知中心
- (void)moviePlayerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlaying:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
}

#pragma mark - 即将播放 移除加载指示器
- (void)startPlaying:(NSNotification *)noti{
    [_activityView stopAnimating];
}
#pragma mark - 播放结束 移除播放视图
- (void)stopPlaying:(NSNotification *)noti{
    [_playerController.view removeFromSuperview];
}

#pragma mark - 给播放按钮添加点击手势
- (void)addTapOnPlayerButton{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayerButton:)];
    self.playerBtn.userInteractionEnabled = YES;
    [self.playerBtn addGestureRecognizer:tap];
}

#pragma mark - tap 方法
- (void)tapPlayerButton:(UITapGestureRecognizer *)tap{
    
    _playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:_dict[@"productionProcessPath"]]];
    
    //设置视频播放器样式
    _playerController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    
    //设置视频播放器的大小及坐标
    _playerController.view.frame = self.playerView.frame;
    
    //将视频播放器添加到视图
    [self.view addSubview:_playerController.view];
    
    
    //创建加载指示器动画
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(SCREEN_WIDTH/2-15, 120, 30, 30);
    
    [self.view addSubview:_activityView];
    
    [_activityView startAnimating];
}

#pragma mark - 设置当前页面的标题和视频播放视图
- (void)setTitlePlayerView{
    self.titleLabel.text = [self.dict objectForKey:@"name"];
    [self.playerView sd_setImageWithURL:[NSURL URLWithString:self.dict[@"imagePathThumbnails"]] placeholderImage:[UIImage imageNamed:@"背景图"]];
    
}

#pragma mark - 监听键盘的通知
- (void)keyBoardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)noti{
    //获得键盘弹起时间
    float time = [[noti.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    //获得键盘弹起高度
    float height = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    [UIView animateWithDuration:time animations:^{
        self.bottomConstraint.constant = height;
        //重新渲染
        [self.view layoutIfNeeded];
    }];
}
- (void)keyBoardWillHide:(NSNotification *)noti{
    float time = [[noti.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:time animations:^{
        self.bottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (open[section] == 1) {
            return _metarilArray.count;
        }else{
            return 0;
        }
        
    }else if (section == 1){
        if (open[section] == 1) {
            return _processArray.count;
        }else{
            return 0;
        }

    }
    else{
        if (open[section] == 1) {
            return 5;
        }else{
            return 0;
        }
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialCell"];

        cell.model = _metarilArray[indexPath.row];
        
        return cell;
    }else if (indexPath.section == 1){
        ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCell"];
        cell.model = _processArray[indexPath.row];
        return cell;
    }
    else{
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        return cell;
    }
}

#pragma mark - tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    imageView.backgroundColor = [UIColor redColor];
    
    NSArray *closedImageArray=@[@"详情-材料",@"详情-步骤",@"详情-常识",@"详情-相宜相克",@"详情评论"];
    
    NSArray *openImageArray=@[@"详情-材料-展开",@"详情-步骤-展开",@"详情-常识-展开",@"详情-相宜相克-展开",@"详情评论"];
    
    NSArray *labelArray=@[@"详情材料",@"详情步骤",@"详情常识",@"相宜相克",@"详情评论"];
    
    //为每个头视图设置背景图
    if (open[section] == 0) {
        imageView.image = [UIImage imageNamed:[closedImageArray objectAtIndex:section]];
    }else{
        imageView.image = [UIImage imageNamed:openImageArray[section]];
    }
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 100, 30)];
    label.text = labelArray[section];
    label.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    imageView.userInteractionEnabled = YES;
    imageView.tag = 100+section;
    [imageView addGestureRecognizer:tap];
    
    return imageView;
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//设置row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1){
        ProcessModel *model = _processArray[indexPath.row];
        NSString *str = model.describe;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        
        return size.height + 150;
    }
    else{
        return 44;
    }
}


- (void)tapClick:(UITapGestureRecognizer *)tap{
    open[tap.view.tag - 100] ^= 1;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag - 100] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.txtField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回按钮 点击事件
- (IBAction)backClick:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark - 发送评论
- (IBAction)sendBtn:(id)sender {
    [self.txtField resignFirstResponder];
}
@end
