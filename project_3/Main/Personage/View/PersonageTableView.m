//
//  PersonageTableView.m
//  project_3
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonageTableView.h"
#import "Common.h"
@implementation PersonageTableView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self =[super initWithCoder:aDecoder];
    if (self) {

//        self.separatorColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//        self.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49);

        self.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    }
  
    return self;
    
}

@end
