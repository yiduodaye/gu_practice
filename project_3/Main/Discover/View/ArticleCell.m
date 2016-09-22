//
//  ArticleCell.m
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArticleCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation ArticleCell

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
        _image.contentMode = UIViewContentModeScaleToFill;
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

- (void)setLayout:(ArticleLayout *)layout {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _layout = layout;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_layout.article.photo_path]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_layout.article.icon_url]];
    
    self.sTitle.text = _layout.article.content;
    self.sDescription.text = _layout.article.title;
    self.dynamic.text = _layout.article.dynamic_info;
    
    self.sTitle.frame = _layout.titleFrame;
    self.sDescription.frame = _layout.descFrame;
    self.dynamic.frame = _layout.dynFrame;
    self.image.frame = _layout.imageFrame;
    self.icon.frame = _layout.iconFrame;
    
    self.sDescription.textColor = [UIColor blackColor];
    self.sTitle.textColor = [UIColor blackColor];
    self.sDescription.alpha = .9;
    self.sTitle.alpha = .55;
    self.sDescription.font = [UIFont systemFontOfSize:15];
    self.sTitle.font = [UIFont systemFontOfSize:12];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
