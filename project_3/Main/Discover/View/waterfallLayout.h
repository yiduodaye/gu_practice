//
//  waterfallLayout.h
//  project_3
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellModel.h"

@interface waterfallLayout : NSObject

//主要的model
//图片（顶死上左右）+5(间隙)+正文（自适应）+10(间隙)+10(按钮栏高度固定)+10(间隙)+用户信息视图(60)+10(间隙)

//单元格宽度固定死为
@property(nonatomic,strong)CellModel *cellModel;
//单元格高度
@property(nonatomic,assign)CGFloat cellHeight;


//图片高度,每个图片的高度不一样， 要计算
@property(nonatomic,assign)CGRect imgFrame;
@property (nonatomic,assign)CGRect priceLabelFrame;

//描述文字的frame（自适应）
@property(nonatomic,assign)CGRect textFrame;
//标签1
@property (nonatomic,assign)CGRect imageViewFrame_1;
@property (nonatomic,assign)CGRect imgaeViewFrame_2;
@property (nonatomic,assign)CGRect imageViewFrame_3;
@property (nonatomic,assign)CGRect labelFrame_1;
@property (nonatomic,assign)CGRect labelFrame_2;
@property (nonatomic,assign)CGRect labelFrame_3;

@property (nonatomic,assign)CGRect shopImgaeViewFrame;



//攒、爱心按钮一栏的高度（固定死的）10
@property(nonatomic,assign)CGRect countFrame;
//用户信息frame（固定死的）60
@property(nonatomic,assign)CGRect userViewFrame;
@property (nonatomic,assign)CGRect iconImageFrame;
@property (nonatomic,assign)CGRect nameLabelFrame;
@property (nonatomic,assign)CGRect usernameLabelFrame;



@end
