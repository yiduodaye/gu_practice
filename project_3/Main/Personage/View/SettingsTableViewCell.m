//
//  SettingsTableViewCell.m
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettingsTableViewCell.h"
#import "Common.h"
@implementation SettingsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self _loadSubView];
        
    }
    return self;
    
}

- (void)_loadSubView{
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20-20-20, self.height -20)];
    [self.contentView addSubview:self.label];
    self.label.font = [UIFont systemFontOfSize:13];
    
    
    self.pushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth -10 -20, 10, 20, 20)];
    [self.contentView addSubview:_pushImageView];
    
    
    self.exitLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 10, 100, 20) ];
    [self.contentView addSubview:_exitLabel];
    self.exitLabel.font = [UIFont systemFontOfSize:13];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
