//
//  HomeCell.h
//  project_3
//
//  Created by Imagine on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLayout.h"

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) HomeLayout *layout;

@property (strong, nonatomic) UILabel *sTitle;
@property (strong, nonatomic) UILabel *sDescription;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *dynamic;

@property (strong, nonatomic) UIImageView *cover;

@end
