//
//  FRGWaterfallCollectionViewCell.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waterfallLayout.h"
#import "CellModel.h"
@class UserView;
@class WXLabel;
@interface FRGWaterfallCollectionViewCell : UICollectionViewCell
//大图
@property(nonatomic,strong)UIImageView *imgView;
//价格（灰色透明，商品才有）
@property(nonatomic,strong)UILabel *priceLabel;
//正文
@property(nonatomic,strong)WXLabel *text;
//1
@property(nonatomic,strong)UIImageView *replyView;
//重复数
@property(nonatomic,strong)UILabel *replay_countLabel;
//2
@property(nonatomic,strong)UIImageView *likeView;
//赞个数
@property(nonatomic,strong)UILabel *like_countLabel;
//3
@property(nonatomic,strong)UIImageView *favoriteView;
//喜欢数
@property(nonatomic,strong)UILabel *favorite_countLabel;
//购物车(商品才有)
@property(nonatomic,strong)UIImageView *shoppingView;

@property(nonatomic,strong)UserView *userView;
//头像
@property(nonatomic,strong)UIImageView *icon;
//笔名
@property(nonatomic,strong)WXLabel *nameLabel;
//用户名（带by）
@property(nonatomic,strong)WXLabel *usernameLabel;

//数据传递
@property(nonatomic,strong)waterfallLayout *layout;



@end
