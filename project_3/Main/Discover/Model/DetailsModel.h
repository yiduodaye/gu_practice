//
//  DetailsModel.h
//  project_3
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailsModel : NSObject


//可以看见的东西
//1.主图
@property(nonatomic,copy)NSString *path;
//图片宽度
@property(nonatomic,assign)NSString *imgWidth;
//图片高度
@property(nonatomic,assign)NSString *imgHeight;

//2.简介
@property(nonatomic,copy)NSString *msg;

//3.标题头像
@property(nonatomic,copy)NSString *source_shortcut_icon;

//4.标题
@property(nonatomic,copy)NSString *source_title;

//5.用户头像：http://img3.duitang.com/uploads/people/201607/18/20160718233101_YQjVe.jpeg
@property(nonatomic,copy)NSString *avatar;

//标签
@property (nonatomic,copy) NSArray *tags;
//6.username
@property(nonatomic,copy)NSString *username;

//7.收藏时间
@property(nonatomic,copy)NSString *add_datetime;

//8.收藏到
@property(nonatomic,copy)NSString *name;
//9.收藏的人,只显示4个专辑
@property(nonatomic,copy)NSArray *related_albums;
//10.收藏这个专辑的总人数
@property(nonatomic,copy)NSString *favorite_count;
//11
//攒的那些人的头像
@property(nonatomic ,copy)NSArray *top_like_users;

//推广


@end
