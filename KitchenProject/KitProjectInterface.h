//
//  KitProjectInterface.h
//  KitProject
//
//  Created by 赵英奎 on 15/9/22.
//  Copyright (c) 2015年 赵英奎. All rights reserved.
//

#ifndef KitProject_KitProjectInterface_h
#define KitProject_KitProjectInterface_h

/**
 应用的网络接口
 */


/*
 菜谱首页数据
 
 user_id    用户ID，未登录写0
 
 
 固定参数：
 is_traditional=0
 page=1
 pageRecord=3
 phonetype=1
 */
#define URL_COOKBOOK @"http://admin.izhangchu.com:80/HandheldKitchen/api/home/tblHomepageVegetable!getHomeVegetableList.do?is_traditional=0&page=1&pageRecord=3&phonetype=1"


//例如： http://admin.izhangchu.com:80/HandheldKitchen/api/home/tblHomepageVegetable!getHomeVegetableList.do?is_traditional=0&page=1&pageRecord=3&phonetype=1


/*
 菜谱首页广告
 
 
 固定参数：
 is_traditional=0
 phonetype=1
 */
#define URL_COOKBOOK_AD @"http://admin.izhangchu.com:80/HandheldKitchen/api/home/tblHomepageVegetable!getSpecialList.do?is_traditional=0&phonetype=1"


/*
 广场
 
 page               第几页
 pageRecord         每页有几个记录
 
 
 固定参数：
 is_traditional=0
 */
#define URL_PLAZA @"http://admin.izhangchu.com:80/HandHeldKitchenCommunity/api/theme/themeProduct!getProductList.do?is_traditional=0&page=1&pageRecord=20"


/*
 分类搜索
 
 name               搜索关键字
 child_catalog_name 中华菜系
 taste              口味分类
 fitting_crowd      人群分类
 cooking_method     烹饪分类
 effect             功效分类
 user_id            用户ID   没有登录可为空串
 
 
 固定参数：
 page               第几页
 pageRecord         每个有几个记录
 phonetype          手机类型
 is_traditional     繁简体
 */
#define URL_VEGETABLE_INFO @"http://admin.izhangchu.com:80/HandheldKitchen/api/vegetable/tblvegetable!getVegetableInfo.do?"


/*
 选择的菜谱的对应信息
 
 vegetable_id       菜谱ID
 type               1，所需原料。2.制作步骤。3.相宜。4.相关常识
 
 
 固定参数：
 phonetype=0
 is_traditional=0
 */
#define URL_VEGETABLE_DETAIL @"http://admin.izhangchu.com:80/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?phonetype=0&is_traditional=0&vegetable_id=%@&type=%i"

// http://admin.izhangchu.com:80/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?phonetype=0&is_traditional=0&vegetable_id=3143&type=2



/*
 材料信息
 
 vegetable_id       菜谱ID
 user_id            用户ID
 
 
 固定参数：
 phonetype=2
 is_traditional=0
 */
#define URL_VEGETABLE_DETAIL_INFO @"http://admin.izhangchu.com:80/HandheldKitchen/api/vegetable/tblvegetable!getTblVegetables.do?"





/*
 登录 POST
 
 loginName  用户ID
 password   密码的MD5的值
 
 
 固定参数：
 md5=3336
 is_traditional=0
 */
#define URL_Login @"http://admin.izhangchu.com:80/HandHeldKitchenCommunity/api/user/users!login.do"







#endif
