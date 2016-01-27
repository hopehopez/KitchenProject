//
//  AFHttpRequest.h
//  KitchenProject
//
//  Created by 张树青 on 16/1/25.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//声明bolck
typedef void(^SuccessBlock)(NSData *data);
typedef void(^FailedBlock)(NSString *failedReason);
@interface AFHttpRequest : NSObject
@property (copy, nonatomic) SuccessBlock sblock;
@property (copy, nonatomic) FailedBlock fblock;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

//声明加载网络数据方法
+ (void)GET:(NSString *)url andSuccess:(SuccessBlock)success andFailed:(FailedBlock) failed;
@end
