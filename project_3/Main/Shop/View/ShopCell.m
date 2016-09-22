//
//  ShopCell.m
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"

@implementation ShopCell

- (UILabel *)sTitle {
    
    if (_sTitle == nil) {
        _sTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _sTitle.backgroundColor = [UIColor clearColor];
        _sTitle.numberOfLines = 0;
        [self.contentView addSubview:_sTitle];
    }
    
    return _sTitle;
}

- (UILabel *)sDescription {
    
    if (_sDescription == nil) {
        _sDescription = [[UILabel alloc] initWithFrame:CGRectZero];
        _sDescription.backgroundColor = [UIColor clearColor];
        _sDescription.numberOfLines = 0;
        [self.contentView addSubview:_sDescription];
    }
    
    return _sDescription;
}

- (UIImageView *)image {
    
    if (_image == nil) {
        _image = [[UIImageView alloc] initWithFrame:CGRectZero];
        _image.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_image];
    }
    
    return _image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLayout:(ShopCellLayout *)layout {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _layout = layout;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_layout.cellModel.image_url]];
    
    self.sTitle.text = _layout.cellModel.sTitle;
    self.sDescription.text = _layout.cellModel.sDescription;
    
    self.sTitle.textAlignment = NSTextAlignmentCenter;
    self.sDescription.textAlignment = NSTextAlignmentCenter;

    self.sTitle.frame = _layout.titleFrame;
    self.sDescription.frame = _layout.descFrame;
    self.image.frame = _layout.imageFrame;
    
    self.sDescription.textColor = [UIColor blackColor];
    self.sTitle.textColor = [UIColor blackColor];
    self.sDescription.alpha = .85;
    self.sTitle.alpha = .6;
    self.sDescription.font = [UIFont systemFontOfSize:16];
    self.sTitle.font = [UIFont systemFontOfSize:11];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
