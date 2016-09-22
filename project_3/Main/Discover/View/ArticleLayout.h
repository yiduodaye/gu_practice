//
//  ArticleLayout.h
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ArticleLayout : NSObject

@property (nonatomic, strong) ArticleModel *article;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect descFrame;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect dynFrame;

@end
