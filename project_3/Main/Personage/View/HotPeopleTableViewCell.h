//
//  HotPeopleTableViewCell.h
//  project_3
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotPeopleCellModel.h"
@class WXLabel;
@class HotPeopleLayout;


@interface HotPeopleTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;
//名字
@property(nonatomic,strong)UILabel *username;
//简介
@property (nonatomic,strong)WXLabel *self_description;
//擅长
@property(nonatomic,strong)WXLabel *love;
//官方认证
@property (nonatomic,strong)WXLabel *daren_description;
//关注按钮
@property ( nonatomic,strong)UIButton *attent;
//头衔头像（右下角黄色）
@property ( nonatomic,strong)UIImageView *identity;

@property(nonatomic,strong)UIView *grayView;


//布局文件
@property (nonatomic,strong)HotPeopleLayout *layout;

@end
