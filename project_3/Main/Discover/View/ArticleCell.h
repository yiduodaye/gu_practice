//
//  ArticleCell.h
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleLayout.h"

@interface ArticleCell : UITableViewCell

@property (nonatomic, strong) ArticleLayout *layout;

@property (strong, nonatomic) UILabel *sTitle;
@property (strong, nonatomic) UILabel *sDescription;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *dynamic;

@end
