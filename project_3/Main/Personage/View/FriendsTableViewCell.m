//
//  FriendsTableViewCell.m
//  project_3
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FriendsTableViewCell.h"
#import "Common.h"
@implementation FriendsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self _loadSubView];
        
    }
    return self;
    
    
}


- (void)_loadSubView {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [self.contentView addSubview:self.iconImageView];
    
    self.typeName= [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right +10, 25/2, 120, 15)];
    [self.contentView addSubview:self.typeName];
    
    self.pushImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20-20, 10, 20, 20)];
    [self.contentView addSubview:self.pushImageView];
    
    
    
}

@end
