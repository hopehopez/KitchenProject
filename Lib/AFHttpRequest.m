//
//  AFHttpRequest.m
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "AFHttpRequest.h"

@implementation AFHttpRequest

+ (void)GET:(NSString *)url andSuccess:(SuccessBlock)success andFailed:(FailedBlock)failed{
    //创建AFHttpRequest的对象 实现AFNetworking的二次封装
    AFHttpRequest *request = [[AFHttpRequest alloc] init];
    request.sblock = success;
    request.fblock = failed;
    request.manager = [AFHTTPRequestOperationManager manager];
    
    //关闭自动解析数据格式的功能
    request.manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [request.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //通过block实现传值
        request.sblock(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        request.fblock(error.localizedDescription);
        
    }];
    
}

@end
