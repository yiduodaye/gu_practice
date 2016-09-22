//
//  HotPeopleLayout.h
//  project_3
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HotPeopleCellModel;
@interface HotPeopleLayout : NSObject

@property(nonatomic,strong) HotPeopleCellModel *model;
@property (nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)CGRect nameFrame;

@property (nonatomic,assign)CGRect iconImageFrame;

@property (nonatomic,assign)CGRect vipImageFrame;

//最长得那段话
@property(nonatomic,assign)CGRect  short_descriptionFrame;
@property (nonatomic,assign)CGRect loveFrame;
//头衔。之类的
@property(nonatomic,assign)CGRect daren_descriptionFrame;
@end
