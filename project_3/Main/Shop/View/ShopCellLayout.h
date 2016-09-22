//
//  ShopCellLayout.h
//  project_3
//
//  Created by Imagine on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShopCellModel.h"

@interface ShopCellLayout : NSObject

@property (nonatomic, strong) ShopCellModel *cellModel;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect descFrame;
@property (nonatomic, assign) CGRect imageFrame;

@end
