//
//  HotPeopleLayout.m
//  project_3
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotPeopleLayout.h"
#import "HotPeopleCellModel.h"
#import "Common.h"
#import "WXLabel.h"
#import "HotPeopleCellModel.h"

@implementation HotPeopleLayout

- (void)setModel:(HotPeopleCellModel *)model {
    
    _model =model;
    
    //model一被创建，就开始获得单元格高度
    //高度初始化为0
    self.cellHeight = 0;
    
    self.iconImageFrame = CGRectMake(10, 10, 40, 40);
    //单元格不用icon来计算高度
    
    self.vipImageFrame = CGRectMake(10+self.iconImageFrame.size.width/2, 10+self.iconImageFrame.size.height/2, self.iconImageFrame.size.width/2, self.iconImageFrame.size.height/2);
    
    
    
    
    
    self.nameFrame = CGRectMake(self.iconImageFrame.size.width+10+10, 10, 120, 15);
    self.cellHeight +=10;//顶端空隙
    self.cellHeight +=CGRectGetHeight(self.nameFrame);
    
    
    //简介
    CGFloat desHeight = [WXLabel getTextHeight:11 width:kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10 text:self.model.short_description];
    self.short_descriptionFrame =CGRectMake(self.iconImageFrame.size.width+10+10, 10+self.nameFrame.size.height+5, kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10, desHeight);
    self.cellHeight +=5;//名字和简介之间的间隙
    self.cellHeight +=desHeight;
    
    
    //daren_tags;
    //拼接,先漏出一个空格
    NSString *loveStr = @"";
    
    for (NSString *str in self.model.daren_tags) {
        loveStr = [NSString stringWithFormat:@"%@, %@",loveStr,str];
    }

    loveStr = [NSString stringWithFormat:@"擅长领域：%@",loveStr];
    
    CGFloat loveHeight = [WXLabel getTextHeight:11 width:kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10 text:loveStr];
    
    self.loveFrame = CGRectMake(self.iconImageFrame.size.width+10+10, 10+self.nameFrame.size.height+5+desHeight+5, kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10, loveHeight);
    self.cellHeight +=5+loveHeight;
    
    
    //identity
    

    CGFloat identityHeight = [WXLabel getTextHeight:11 width:kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10  text:self.model.daren_description];
    
    self.daren_descriptionFrame = CGRectMake(self.iconImageFrame.size.width+10+10, 10+self.nameFrame.size.height+5+desHeight+5+loveHeight+5, kScreenWidth-10-10-self.iconImageFrame.size.width-2-60-10, identityHeight);
    self.cellHeight +=5+identityHeight;
    
    self.cellHeight +=10 ;//和底边间距;
    
    
    
    
}

@end
