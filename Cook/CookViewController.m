//
//  CookViewController.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "CookViewController.h"
#import "CookCell.h"
#import "CookModel.h"
#import "MediaViewController.h"
#import "SearchViewController.h"
@interface CookViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
    //声明表格头视图的变量
    UIScrollView *_headerView;
    //声明cell的数据源数组
    NSMutableArray *_contentArray;
    //声明pageControl
    UIPageControl *_pageControl;
}

@end

@implementation CookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //实例化数据源数组
    _contentArray = [NSMutableArray array];
    
    self.navigationController.navigationBarHidden = YES;
    
    //设置回调
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self registerCookCellInTableView];
    
    [self addTableHeaderView];
    
    [self loadTableViewCellRequest];
    
    [self loadAdRequest];
    
    [self addPageControlOnTableView];
    
    [self prepareToMediaViewController];
}


#pragma mark - 注册通知 监听播放按钮的点击
- (void)prepareToMediaViewController{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toMediaViewController:) name:@"MediaViewController" object:nil];
    
}
#pragma mark - 监听调用的方法 跳转到视频控制器
- (void)toMediaViewController:(NSNotification *)noti{
    
    MediaViewController *mediaView = [[MediaViewController alloc] init];
    mediaView.hidesBottomBarWhenPushed = YES;
    mediaView.dict = noti.object;
    [self.navigationController pushViewController:mediaView animated:YES];
}

#pragma mark - 添加pageControl
- (void)addPageControlOnTableView{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 160, 60, 30)];
    _pageControl.numberOfPages = 4;
    [self.tableView addSubview:_pageControl];
}

#pragma mark - 加载广告网络数据
- (void)loadAdRequest{
    [AFHttpRequest GET:URL_COOKBOOK_AD andSuccess:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = [dict objectForKey:@"data"];
        for (int i = 0; i<array.count; i++) {
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, 200)];
            NSDictionary *dataDict = array[i];
            [imgv sd_setImageWithURL:[NSURL URLWithString:dataDict[@"imageFilename"]] placeholderImage:[UIImage imageNamed:@"背景图"] options:SDWebImageRefreshCached];
            [_headerView addSubview:imgv];
        }
        
        //设置滚动视图显示内容的大小
        _headerView.contentSize = CGSizeMake(SCREEN_WIDTH * array.count, 200);
        _headerView.pagingEnabled = YES;
        
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@", failedReason);
    }];
}

#pragma mark - loadData
- (void)loadTableViewCellRequest{
    //加载自定制Cell中的网络数据
    [AFHttpRequest GET:URL_COOKBOOK andSuccess:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = [dict objectForKey:@"data"];
        
        for (NSDictionary *dic in array) {
            CookModel *model = [[CookModel alloc] init];
            //通过网络数据给模型赋值
            [model setValuesForKeysWithDictionary:dic];
            //将模型添加到数据源数组中
            [_contentArray addObject:model];
        }
        [_tableView reloadData];
        
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@", failedReason);
    }];
}

#pragma mark - 添加表格头视图
- (void)addTableHeaderView{
    //创键滚动视图对象
    _headerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    self.tableView.tableHeaderView = _headerView;
    _headerView.backgroundColor = [UIColor redColor];
    //设置代理回调
    _headerView.delegate = self;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}




#pragma mark - data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"CookCellID";
    
    CookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[CookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CookModel *model = _contentArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

#pragma mark - 注册自定制cell
- (void)registerCookCellInTableView{
    UINib *nib = [UINib nibWithNibName:@"CookCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"CookCellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchClick:(id)sender {
    
    SearchViewController *seachView = [[SearchViewController alloc] init];
    seachView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachView animated:YES];
    
}
@end
