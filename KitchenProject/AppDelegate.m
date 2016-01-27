//
//  AppDelegate.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FindViewController.h"
#import "CookViewController.h"
#import "SquareViewController.h"
#import "MineViewController.h"
@interface AppDelegate (){
    //菜谱视图控制器
    CookViewController *_cookController;
    UINavigationController *_cookNav;
    
    //发现视图控制器
    FindViewController *_findController;
    UINavigationController *_findNav;
    
    //广场视图控制器
    SquareViewController *_squareController;
    UINavigationController *_squareNav;
    
    //我的视图控制器
    MineViewController *_mineController;
    UINavigationController *_mineNav;
    
    
    //主视图控制器
    MainViewController *_mainController;
    
}
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.window.rootViewController = [self createRootController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

#pragma mark - 创建视图控制器
- (UIViewController * )createRootController{
    //创建菜谱视图控制器
    _cookController = [[CookViewController alloc] init];
    _cookNav = [[UINavigationController alloc] initWithRootViewController:_cookController];
    UITabBarItem *cookItem = [[UITabBarItem alloc] initWithTitle:@"菜谱" image:[UIImage imageNamed:@"菜谱-A"] selectedImage:[UIImage imageNamed:@"菜谱-B"]];
    _cookNav.tabBarItem  = cookItem;
    
    //创建发现视图控制器
    _findController = [[FindViewController alloc] init];
    _findNav = [[UINavigationController alloc] initWithRootViewController:_findController];
    UITabBarItem *findItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"发现-A"] selectedImage:[UIImage imageNamed:@"发现-B"]];
    _findNav.tabBarItem = findItem;
    
    //创建广场视图控制器
    _squareController = [[SquareViewController alloc] init];
    _squareNav = [[UINavigationController alloc] initWithRootViewController:_squareController];
    UITabBarItem *squareItem = [[UITabBarItem alloc] initWithTitle:@"广场" image:[UIImage imageNamed:@"广场-A"] selectedImage:[UIImage imageNamed:@"广场-B"]];
    _squareNav.tabBarItem = squareItem;
    
    //创建我的视图控制器
    _mineController = [[MineViewController alloc] init];
    _mineNav = [[UINavigationController alloc] initWithRootViewController:_mineController];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的-A"] selectedImage:[UIImage imageNamed:@"我的-B"]];
    _mineNav.tabBarItem = mineItem;
    
    //创建跟视图控制器对象
    _mainController = [[MainViewController alloc] init];
    
    
    //添加标签控制器中的子控制器
    _mainController.viewControllers = @[_cookNav, _findNav, _squareNav, _mineNav];
    
    return _mainController;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
