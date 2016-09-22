//
//  DiscoverHeaderView.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverHeaderView.h"
#import "Common.h"
@implementation DiscoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame  text:(NSString *)text{
    self =[super initWithFrame:frame];
    if (self) {
        //固定size
        self.width =kScreenWidth;
        self.height =30;
        self.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 20)];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        textLabel.text =text;
        [self addSubview:textLabel]; 
    }
    return self;
}

@end
