//
//  CellModel.h
//  project_3
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject


//主图
@property(nonatomic,copy)NSString *path;
//图片宽度
@property(nonatomic,assign)NSInteger imgWidth;
//图片高度
@property(nonatomic,assign)NSInteger imgHeight;
//用户头像图片地址
@property(nonatomic,copy)NSString *avatar;
//图片描述
@property(nonatomic,copy)NSString *msg;
//别名（发表名字、笔名之类的）
@property(nonatomic,copy)NSString *name;
//用户名字(前面接了by)
@property(nonatomic,copy)NSString *username;
//重复次数
@property(nonatomic,assign)NSInteger reply_count;
//攒的次数！
@property(nonatomic,assign)NSInteger like_count;
//喜欢的次数
@property(nonatomic,assign)NSInteger favorite_count;

//id。用于跳转的请求数据提交的参数
@property(nonatomic,copy)NSString *numberID;



//可能还会出现商品,多出来两个属性
//价格(前面跟个¥)
@property(nonatomic,copy)NSString *price;
//是否可以购买(yes情况有购物车图标).
@property(nonatomic,assign)BOOL buyable;
//购物车图片来源于淘宝网
@property(nonatomic,assign)NSString *icon_url;

//其他未显示在cell里面的属性




@end
