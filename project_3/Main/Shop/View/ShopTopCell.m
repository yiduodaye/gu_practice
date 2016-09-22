//
//  ShopTopCell.m
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopTopCell.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@implementation ShopTopCell 


- (void)awakeFromNib {
    
    // Initialization code
}

- (UIImageView *)topImage {
    
    if (_topImage == nil) {
        _topImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topImage.image = [UIImage imageNamed:@"tou.png"];
        [self.contentView addSubview:_topImage];
    }
    
    return _topImage;
}

- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topImage.frame.size.height, kScreenWidth, kScreenWidth * 35 / 64)];
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = YES;
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.scrollEnabled = YES;
        
        _scrollView.delegate = self;
        
        [self.contentView addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (UIPageControl *)page {
    
    if (_page == nil) {
        
        _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.topImage.frame.size.height + self.scrollView.size.height - 25, kScreenWidth, 20)];
        
        _page.currentPage = 0;
        
        [self addSubview:_page];
    }
    
    return _page;
}

- (UIView *)leftView {
    
    if (_leftView == nil) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, _cellHeigt, kScreenWidth / 2, kScreenWidth / 2 + 10)];
        [self.contentView addSubview:_leftView];
    }
    
    return _leftView;
}

- (UIView *)rightView {
    
    if (_rightView == nil) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, _cellHeigt, kScreenWidth / 2, kScreenWidth / 2 + 10)];
        
        [self.contentView addSubview:_rightView];
    }
    
    return _rightView;
}

- (void)setTopModel:(TopModel *)topModel {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _topModel = topModel;
    
    NSInteger start = [_topModel.start integerValue];
    
    [self _loadScrollView:start];
    
    [self _loadIcon];
    
    [self _loadtwoItem];
}

- (void)_loadScrollView:(NSInteger)page {
    
    //移除所有_scrollView上的子视图
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
 
    for (NSInteger i = 0; i < page; i++) {
        NSDictionary *dic = _topModel.array[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + i * kScreenWidth, 0, kScreenWidth, self.scrollView.frame.size.height)];
        [imageView sd_setImageWithURL:dic[@"image_url"]];
        
        if (![dic[@"description"] isEqualToString:@""]) {
            
            UIImageView *cover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollView.frame.size.height)];
            cover.backgroundColor = [UIColor grayColor];
            cover.alpha = .3;
            
            UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollView.size.height / 35 * 9, kScreenWidth, 30)];
            desc.text = dic[@"description"];
            desc.font = [UIFont systemFontOfSize:25 weight:16];
            desc.textColor = [UIColor whiteColor];
            desc.textAlignment = NSTextAlignmentCenter;
            
            UILabel *stit = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollView.size.height / 35 * 16, kScreenWidth, 10)];
            stit.text = dic[@"stitle"];
            stit.font = [UIFont systemFontOfSize:11];
            stit.textColor = [UIColor whiteColor];
            stit.textAlignment = NSTextAlignmentCenter;
            
            UILabel *icon = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 90) / 2, self.scrollView.size.height / 175 * 103, 95, 26)];
            icon.text = @"查看详情";
            icon.font = [UIFont systemFontOfSize:12];
            icon.textColor = [UIColor whiteColor];
            icon.textAlignment = NSTextAlignmentCenter;
            
            icon.layer.borderWidth = 1;
            icon.layer.borderColor = [UIColor whiteColor].CGColor;
            icon.layer.cornerRadius = 12;
            
            [imageView addSubview:cover];
            [imageView addSubview:desc];
            [imageView addSubview:stit];
            [imageView addSubview:icon];
        }
        
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(page * kScreenWidth, self.scrollView.frame.size.height);
    
    self.page.numberOfPages = page;
}

- (void)_loadIcon {
    
    if (_leftView == nil && _rightView == nil) {
        
        NSArray *wordsArr = @[@"护肤",@"彩妆",@"个人护理",@"进口食品",@"文具",@"家居",@"畅销单品",@"全部分类"];
        
        CGFloat width = kScreenWidth / 4;
        CGFloat height = width - 10;
        
        for (NSInteger i = 0; i < 8; i++) {
            
            NSInteger row = i / 4;
            NSInteger clomn = i - 4 * row;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(clomn * width, row * height + self.topImage.frame.size.height + _scrollView.frame.size.height, width, height)];
            view.backgroundColor = [UIColor whiteColor];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((width - 35) / 2, 10, 35, 35)];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", i + 1]] forState:UIControlStateNormal];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, width, 20)];
            label.text = wordsArr[i];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            
            [view addSubview:label];
            [view addSubview:button];
            [self.contentView addSubview:view];
        }
        
        _cellHeigt = self.topImage.frame.size.height + self.scrollView.frame.size.height + 2 * height;
    }
}

- (void)_loadtwoItem {

    if (_leftView == nil && _rightView == nil) {
        
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(33, 20, self.leftView.frame.size.width - 2 * 33, _leftView.frame.size.width - 2 * 33)];
        leftImage.image = [UIImage imageNamed:@"meiri.png"];
        UILabel *leftLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, leftImage.bottom + 10, kScreenWidth / 2, 20)];
        leftLabel1.alpha = .9;
        leftLabel1.textAlignment = NSTextAlignmentCenter;
        leftLabel1.font = [UIFont systemFontOfSize:16];
        leftLabel1.text = @"每日上新";
        
        UILabel *leftLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, leftImage.bottom + 30, kScreenWidth / 2, 20)];
        leftLabel2.alpha = .7;
        leftLabel2.textAlignment = NSTextAlignmentCenter;
        leftLabel2.font = [UIFont systemFontOfSize:9];
        leftLabel2.tintColor = [UIColor grayColor];
        leftLabel2.text = @"每天10:00更新";
        
        [self.leftView addSubview:leftLabel1];
        [self.leftView addSubview:leftLabel2];
        [self.leftView addSubview:leftImage];
        
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(33, 20, self.rightView.frame.size.width - 2 * 33, self.rightView.frame.size.width - 2 * 33)];
        rightImage.image = [UIImage imageNamed:@"koubei.png"];
        UILabel *rightLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, rightImage.bottom + 10, kScreenWidth / 2, 20)];
        rightLabel1.alpha = .9;
        rightLabel1.textAlignment = NSTextAlignmentCenter;
        rightLabel1.font = [UIFont systemFontOfSize:16];
        rightLabel1.text = @"口碑排行";
        
        UILabel *rightLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, leftImage.bottom + 30, kScreenWidth / 2, 20)];
        rightLabel2.alpha = .7;
        rightLabel2.textAlignment = NSTextAlignmentCenter;
        rightLabel2.font = [UIFont systemFontOfSize:9];
        rightLabel2.tintColor = [UIColor grayColor];
        rightLabel2.text = @"每周三更新";
        
        [self.rightView addSubview:rightLabel1];
        [self.rightView addSubview:rightLabel2];
        [self.rightView addSubview:rightImage];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint contenOffset = self.scrollView.contentOffset;
    self.page.currentPage = (contenOffset.x + kScreenWidth / 2) / kScreenWidth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
