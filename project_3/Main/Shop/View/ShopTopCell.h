//
//  ShopTopCell.h
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"

@interface ShopTopCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) TopModel *topModel;

@property (nonatomic, assign) CGFloat cellHeigt;
@property (strong, nonatomic) UIImageView *topImage;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *page;

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;

@end
