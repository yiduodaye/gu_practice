//
//  ShopCell.h
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCellLayout.h"

@interface ShopCell : UITableViewCell

@property (nonatomic, strong) ShopCellLayout *layout;

@property (strong, nonatomic) UILabel *sTitle;
@property (strong, nonatomic) UILabel *sDescription;
@property (strong, nonatomic) UIImageView *image;

@end
