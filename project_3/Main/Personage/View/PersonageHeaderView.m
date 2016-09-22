//
//  PersonageHeaderView.m
//  project_3
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonageHeaderView.h"
#import "Common.h"
@implementation PersonageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        [self addTitle];
        self.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    }
    return self;
}


- (void)addTitle{
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.height-10)/2, 100, 10)];
    self.title.textColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.title];
}
@end
