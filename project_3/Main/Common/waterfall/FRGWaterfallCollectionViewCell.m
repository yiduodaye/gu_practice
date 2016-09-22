//
//  FRGWaterfallCollectionViewCell.m
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import "FRGWaterfallCollectionViewCell.h"
#import "Common.h"
#define CellWidth (kScreenWidth-40)/2
#import "UserView.h"
#import "UIImageView+WebCache.h"
#import "WXLabel.h"

@interface FRGWaterfallCollectionViewCell()

@end

@implementation FRGWaterfallCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
         [self _createSubView];
    }
    return self;
}


- (void)setLayout:(waterfallLayout *)layout {
    _layout =layout;
    [self setNeedsLayout];
    
}

- (void)layoutSubviews {
    //布局视图frame
    //填充视图显示内容
    
    //1.大图(贴紧父视图)
    
    self.imgView.frame =self.layout.imgFrame;

   // [_imgView sd_setImageWithURL:[NSURL URLWithString:self.layout.cellModel.path]];

    
    //调低分辨率，使图片看起来舒服一点
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.layout.cellModel.path]]];
    
    image = [self OriginImage:image scaleToSize:self.layout.imgFrame.size];
    _imgView.image =image;
    
    
    
    [self.contentView addSubview:_imgView];
    
  

    
    
    //灰色价格标签
//  
    self.priceLabel.frame=self.layout.priceLabelFrame;
        _priceLabel.backgroundColor = [UIColor blackColor];
    _priceLabel.alpha=0.6;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",self.layout.cellModel.price];
  
    [self.contentView addSubview:_priceLabel];
    _priceLabel.hidden=YES;
        
        //购物车
        //图片从网上获取.
    
    self.shoppingView.frame=self.layout.shopImgaeViewFrame;
        [_shoppingView sd_setImageWithURL:[NSURL URLWithString:self.layout.cellModel.icon_url]];
    if (self.layout.cellModel.buyable) {
        _priceLabel.hidden=NO;
        _priceLabel.font = [UIFont systemFontOfSize:10];
        _priceLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _priceLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_shoppingView];
    }
   
    
    
    
    
    //2.正文(文字有段落格式，前面加两个空格).高度自适应的
    self.text.frame=self.layout.textFrame;
    _text.text =self.layout.cellModel.msg;
    _text.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_text];
    
    //3.图标1
    self.replyView.frame=self.layout.imageViewFrame_1;
    _replyView.contentMode =UIViewContentModeScaleAspectFill;
    _replyView.image = [UIImage imageNamed:@"blog_list_icon_comments@2x.png"];
    [self.contentView addSubview:_replyView];
    
    //4.标签1
    self.replay_countLabel.frame=self.layout.labelFrame_1;
    _replay_countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.layout.cellModel.reply_count ];
    _replay_countLabel.font = [UIFont systemFontOfSize:8];
    _replay_countLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:_replay_countLabel];
    
    //5.图标2
    self.likeView.frame=self.layout.imgaeViewFrame_2;
    
    _likeView.contentMode =UIViewContentModeScaleAspectFill;
    _likeView.image = [UIImage imageNamed:@"blog_list_icon_good@2x.png"];
    [self.contentView addSubview:_likeView];
    
    //6.标签2
    self.like_countLabel.frame=self.layout.labelFrame_2;
    _like_countLabel.text = [NSString stringWithFormat:@"%ld",self.layout.cellModel.like_count];
    _like_countLabel.font = [UIFont systemFontOfSize:8];
    _like_countLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:_like_countLabel];
    
    
    //7.图标3.
    self.favoriteView.frame=self.layout.imageViewFrame_3;
    _favoriteView.contentMode =UIViewContentModeScaleAspectFill;
    _favoriteView.image = [UIImage imageNamed:@"blog_list_icon_star@2x.png"];
    [self.contentView addSubview:_favoriteView];
    
    //8.标签3
    self.favorite_countLabel.frame=self.layout.labelFrame_3;
    _favorite_countLabel.text = [NSString stringWithFormat:@"%ld",self.layout.cellModel.favorite_count];
    _favorite_countLabel.font = [UIFont systemFontOfSize:8];
    _favorite_countLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:_favorite_countLabel];
    
    
    
    
    
    //9.用户信息
    //如果子视图的frame不写在layout里面，一定要相对布局
    
    _userView.frame=self.layout.userViewFrame;
    [self.contentView addSubview:_userView];
    _userView.backgroundColor = [UIColor whiteColor];
    
    
    self.icon.frame=self.layout.iconImageFrame;
    [_icon sd_setImageWithURL:[NSURL URLWithString:self.layout.cellModel.avatar]];
    _icon.layer.cornerRadius =15;
    _icon.layer.masksToBounds=YES;
    [_userView addSubview:_icon];
    
    
    self.nameLabel.frame=self.layout.nameLabelFrame;
    _nameLabel.text = self.layout.cellModel.name;
    _nameLabel.font = [UIFont systemFontOfSize: 12];
   
    [_userView addSubview:_nameLabel];
    
    
    self.usernameLabel.frame=self.layout.usernameLabelFrame;

    _usernameLabel.text =[NSString stringWithFormat:@"by %@",self.layout.cellModel.username];
        _usernameLabel.font = [UIFont systemFontOfSize:10];
    [_userView addSubview:_usernameLabel];

    
    
}


/*
 //大图
 @property(nonatomic,strong)UIImageView *imgView;
 //价格（灰色透明，商品才有）
 @property(nonatomic,strong)UILabel *priceLabel;
 //正文
 @property(nonatomic,strong)UILabel *text;
 //1
 @property(nonatomic,strong)UIImageView *replyView;
 //重复数
 @property(nonatomic,strong)UILabel *replay_countLabel;
 //2
 @property(nonatomic,strong)UIImageView *likeView;
 //赞个数
 @property(nonatomic,strong)UILabel *like_countLabel;
 //3
 @property(nonatomic,strong)UIImageView *favoriteView;
 //喜欢数
 @property(nonatomic,strong)UILabel *favorite_countLabel;
 //购物车(商品才有)
 @property(nonatomic,strong)UIImageView *shoppingView;
 //头像
 @property(nonatomic,strong)UIImageView *icon;
 //笔名
 @property(nonatomic,strong)UILabel  *nameLabel;
 //用户名（带by）
 @property(nonatomic,strong)UILabel *usernameLabel;
 
 //数据传递
 @property(nonatomic,strong)waterfallLayout *layout;

 */
- (void)_createSubView{
    
    //创建视图
    
    
    //1.大图(贴紧父视图)
    self.imgView = [[UIImageView alloc] init];
#warning 对图像进行压缩  ......
    //对图像进行压缩
    /*UIViewContentModeScaleToFill,
     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,

     */
    _imgView.contentMode=UIViewContentModeScaleAspectFit;

    self.priceLabel = [[UILabel alloc] init];
        
        //购物车
        //图片从网上获取.
        
     self.shoppingView = [[UIImageView alloc] init];
    
 
    
    
    //2.正文(文字有段落格式，前面加两个空格).高度自适应的
    self.text = [[WXLabel alloc] init];
    
    //3.图标1
    self.replyView = [[UIImageView alloc] init];
    
    //4.标签1
    self.replay_countLabel = [[UILabel alloc] init];
    
    //5.图标2
    self.likeView = [[UIImageView alloc] init];
    
    //6.标签2
    self.like_countLabel = [[UILabel alloc] init];

    
    //7.图标3.
    self.favoriteView = [[UIImageView alloc] init];
    //8.标签3
    self.favorite_countLabel = [[UILabel alloc] init];
    
    
  
    
    
    //9.用户信息
    
    _userView = [[UserView alloc ] init];
 
    
    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode =UIViewContentModeScaleAspectFill;
    
    self.nameLabel = [[WXLabel alloc] init];
    
    self.usernameLabel = [[WXLabel alloc] init];
    
    
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
