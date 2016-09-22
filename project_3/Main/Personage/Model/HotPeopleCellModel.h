//
//  HotPeopleCellModel.h
//  project_3
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotPeopleCellModel : NSObject


//头像来源
@property(nonatomic,copy)NSString *avatar;
//名字
@property (nonatomic,copy)NSString *username;
//（初步定为）是否关注。否为0
@property (nonatomic,assign)NSInteger relationship;
//简介
@property (nonatomic,copy)NSString *short_description;
//连接
@property (nonatomic,copy)NSString *target;

//爱好、擅长
@property(nonatomic,copy)NSMutableArray *daren_tags;
//（几乎每个人的值都为空，暂时没用）。
@property(nonatomic,copy)NSString *daren_type;
//认证简介
@property(nonatomic,copy)NSString *daren_description;

//是否被认证。personal_certify/normal (头像右下角VIP黄色图片)
@property (nonatomic,copy)NSMutableArray *daren_identity;
@end
