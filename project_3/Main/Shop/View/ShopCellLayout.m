//
//  ShopCellLayout.m
//  project_3
//
//  Created by Imagine on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopCellLayout.h"
#import "Common.h"

#define kSpace 10

@implementation ShopCellLayout

- (void)setCellModel:(ShopCellModel *)cellModel {
    
    _cellModel = cellModel;
    
    self.imageFrame = CGRectMake(1.5 * kSpace, 1.5 * kSpace, kScreenWidth - 3 * kSpace, (kScreenWidth - 3 * kSpace) * 17 / 29);
    
    self.descFrame = CGRectMake(0, CGRectGetMaxY(self.imageFrame) + 7, kScreenWidth, 20);
    self.titleFrame = CGRectMake(0, CGRectGetMaxY(self.descFrame), kScreenWidth, 20);
    
    _cellHeight = CGRectGetHeight(self.imageFrame) + CGRectGetHeight(self.descFrame) + CGRectGetHeight(self.titleFrame) +  3 * kSpace;
}

@end
