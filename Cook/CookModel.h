//
//  CookModel.h
//  KitchenProject
//
//  Created by 张树青 on 16/1/26.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageFilename;
@property (nonatomic, strong) NSArray *vegetableList;

//当网络数据的键值对个数大于属性个数时, 需要声明该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
