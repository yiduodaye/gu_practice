//
//  HomeCell.m
//  project_3
//
//  Created by Imagine on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation HomeCell



- (void)awakeFromNib {
    // Initialization code
}

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

- (UILabel *)dynamic {
    
    if (_dynamic == nil) {
        _dynamic = [[UILabel alloc] initWithFrame:CGRectZero];
        _dynamic.backgroundColor = [UIColor clearColor];
        _dynamic.font = [UIFont systemFontOfSize:11];
        _dynamic.alpha = .45;
        _dynamic.numberOfLines = 0;
        [self.contentView addSubview:_dynamic];
    }
    
    return _dynamic;
}

- (UIImageView *)image {
    
    if (_image == nil) {
        _image = [[UIImageView alloc] initWithFrame:CGRectZero];
        _image.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_image];
    }
    
    return _image;
}

- (UIImageView *)icon {
    
    if (_icon == nil) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _icon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_icon];
    }
    
    return _icon;
}

- (UIImageView *)cover {
    
    if (_cover == nil) {
        _cover = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cover.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_image];
    }
    
    return _cover;
}

- (void)setLayout:(HomeLayout *)layout {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _layout = layout;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_layout.home.image_url]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_layout.home.icon_url]];
    self.cover.image = [UIImage imageNamed:@"banner_cover@2x.png"];

    self.sTitle.text = _layout.home.sTitle;
    self.sDescription.text = _layout.home.sDescription;
    
    self.dynamic.text = _layout.home.dynamic_info;
    self.sTitle.frame = _layout.titleFrame;
    self.sDescription.frame = _layout.descFrame;
    self.dynamic.frame = _layout.dynFrame;
    self.image.frame = _layout.imageFrame;
    self.icon.frame = _layout.iconFrame;
   
    if ([_layout.home.style isEqualToString:@"large"]) {
        self.sDescription.textColor = [UIColor whiteColor];
        self.sTitle.textColor = [UIColor whiteColor];
        self.sDescription.alpha = 1;
        self.sTitle.alpha = 1;
        self.sDescription.font = [UIFont systemFontOfSize:18];
        self.sTitle.font = [UIFont systemFontOfSize:13];
        
        //重置了文字的y值
        self.sDescription.bottom = self.layout.cellHeight * 31.5 / 34;
        
        if (![_layout.home.sTitle isEqualToString:@""]) {
            self.sTitle.bottom = self.layout.cellHeight * 31 / 34;
            self.sDescription.bottom = self.sTitle.top - 5;
        }
            
        self.cover.frame = _layout.imageFrame;
        
        [self.contentView addSubview:_cover];
        [self.contentView addSubview:self.sTitle];
        [self.contentView addSubview:self.sDescription];
        
    } else {
        self.sDescription.textColor = [UIColor blackColor];
        self.sTitle.textColor = [UIColor blackColor];
        self.sDescription.alpha = .9;
        self.sTitle.alpha = .55;
        self.sDescription.font = [UIFont systemFontOfSize:15];
        self.sTitle.font = [UIFont systemFontOfSize:13];
        
        self.cover.frame = CGRectZero;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
