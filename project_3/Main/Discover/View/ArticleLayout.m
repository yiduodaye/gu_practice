//
//  ArticleLayout.m
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArticleLayout.h"
#import "ArticleModel.h"
#import "Common.h"

#define kSpace 10

@implementation ArticleLayout

- (void)setArticle:(ArticleModel *)article {
    
    _article = article;
    
    self.cellHeight = kScreenWidth * 11 / 32;
    
    self.imageFrame = CGRectMake(1.2 * kSpace, kSpace, kScreenWidth * 9 / 32, kScreenWidth * 9 / 32);
    
    CGRect rect1 = [self.article.title boundingRectWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 11 / 32 - kSpace, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
    
    self.descFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, kSpace, kScreenWidth - kScreenWidth * 11 / 32 - kSpace, rect1.size.height);
    
    CGRect rect2 = [self.article.content boundingRectWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 11 / 32 - kSpace, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
    
    self.titleFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, CGRectGetMaxY(self.descFrame) + 0.2 * kSpace, kScreenWidth - kScreenWidth * 11 / 32 - kSpace, rect2.size.height);
    
    self.iconFrame = CGRectMake(CGRectGetMaxX(self.imageFrame) + kSpace, self.cellHeight * 17/ 22, self.cellHeight * 3 / 22, self.cellHeight * 3 / 22);
    self.dynFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + kSpace / 2, self.cellHeight * 17/ 22, kScreenWidth - kScreenWidth * 11 / 32, self.cellHeight * 3 / 22);
    
}

@end
