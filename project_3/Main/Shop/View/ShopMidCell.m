//
//  ShopMidCell.m
//  project_3
//
//  Created by Imagine on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopMidCell.h"
#import "Common.h"

#define kSpace 10

@implementation ShopMidCell

- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth / 2.2)];
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = YES;
        
        _scrollView.pagingEnabled = NO;
        
        _scrollView.scrollEnabled = YES;
        
        _scrollView.contentSize = CGSizeMake(3 * kScreenWidth - 3 * kSpace, _scrollView.frame.size.height);
        
        [self.contentView addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (UIButton *)bottomView {
    
    if (_bottomView == nil) {
        _bottomView = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), kScreenWidth, kScreenWidth / 6)];
        
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_bottomView];
    }
    
    return _bottomView;
}

- (void)awakeFromNib {
    // Initialization code
    
    [self _loadScrollView];
    
    [self _loadBottomView];
}

- (void)_loadScrollView {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSInteger i = 0; i < 9; i ++) {
        
        CGFloat width = (kScreenWidth - 4 * 1.5 * kSpace) / 3;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1.5 * kSpace + i * (1.5 * kSpace + width), 1.5 * kSpace, width, width)];
        
        imageView.image = [UIImage imageNamed:@"baby.png"];
        
        [self.scrollView addSubview:imageView];
    }
}

- (void)_loadBottomView {
    
    if (_bottomView == nil) {
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.bottomView.frame))];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = @"查看全部";
        label1.font = [UIFont systemFontOfSize:13];
        label1.alpha = .85;
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.bottomView.frame))];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.text = @"                    >";
        label2.font = [UIFont systemFontOfSize:13];
        label2.alpha = .35;
        
        [self.bottomView addSubview:label1];
        [self.bottomView addSubview:label2];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
