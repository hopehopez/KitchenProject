//
//  MaterialModel.h
//  KitchenProject
//
//  Created by yhy on 16/1/27.
//  Copyright (c) 2016年 yhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialModel : NSObject

@property (nonatomic,copy)NSString *materialName;

@property (nonatomic,copy)NSString *imagePath;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
