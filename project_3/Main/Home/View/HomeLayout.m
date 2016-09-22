//
//  HomeLayout.m
//  project_3
//
//  Created by Imagine on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeLayout.h"
#import "HomeModel.h"
#import "Common.h"

#define kSpace 10

@implementation HomeLayout

- (void)setHome:(HomeModel *)home {
    
    _home = home;
    
    if ([_home.style isEqualToString:@"large"]) {
        
        self.cellHeight = kScreenWidth * 17 / 32;
        
        if ([_home.sTitle isEqualToString:@""]) {
            self.descFrame = CGRectMake(1.5 * kSpace, 0, kScreenWidth - 50, 40);
            self.titleFrame = CGRectZero;
        } else {
            
            self.descFrame = CGRectMake(1.5 * kSpace, 0, kScreenWidth - 60, 20);
            
            CGRect rect1 = [self.home.sTitle boundingRectWithSize:CGSizeMake(kScreenWidth - 110, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
            
            self.titleFrame = CGRectMake(1.5 * kSpace, 0, kScreenWidth - 110, rect1.size.height);
        }
        
        self.imageFrame = CGRectMake(0, 0, kScreenWidth, self.cellHeight);
        self.iconFrame = CGRectZero;
        self.dynFrame = CGRectZero;
    } else if ([_home.style isEqualToString:@"small"]) {
        
        self.cellHeight = kScreenWidth * 11 / 32;
        
        self.imageFrame = CGRectMake(1.2 * kSpace, kSpace, kScreenWidth * 9 / 32, kScreenWidth * 9 / 32);
        
        CGRect rect1 = [self.home.sDescription boundingRectWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 11 / 32 - kSpace, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
        
        self.descFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, kSpace, kScreenWidth - kScreenWidth * 11 / 32 - kSpace, rect1.size.height);
        
        CGRect rect2 = [self.home.sTitle boundingRectWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 11 / 32 - kSpace, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
        
        self.titleFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, CGRectGetMaxY(self.descFrame) + kSpace / 2, kScreenWidth - kScreenWidth * 11 / 32 - kSpace, rect2.size.height);
        
        self.iconFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, self.cellHeight * 17/ 22, self.cellHeight * 3 / 22, self.cellHeight * 3 / 22);
        self.dynFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + kSpace / 2, self.cellHeight * 17/ 22, kScreenWidth - kScreenWidth * 11 / 32, self.cellHeight * 3 / 22);
    }
}

@end
