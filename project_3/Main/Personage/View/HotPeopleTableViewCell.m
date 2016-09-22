//
//  HotPeopleTableViewCell.m
//  project_3
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotPeopleTableViewCell.h"
#import "HotPeopleLayout.h"
#import "WXLabel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"


@implementation HotPeopleTableViewCell

- (void)awakeFromNib {
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createView];
    }
    return self;
    
}

- (void)setLayout:(HotPeopleLayout *)layout {
    _layout =layout ;
    [self setNeedsLayout];
    
}

//这里创建不添加，不然会重叠，需要的时候才添加，不需要就不添加
- (void)_createView {
    
    self.icon = [[UIImageView alloc] init];
    self.daren_description = [[WXLabel alloc] init];
    self.self_description = [[WXLabel alloc] init];
    self.love = [[WXLabel alloc] init];
    self.attent = [UIButton buttonWithType:UIButtonTypeCustom];
    self.identity = [[UIImageView alloc] init];
    self.username = [[UILabel alloc] init];
}

//这里初始化

- (void)layoutSubviews {
    
    //相对布局于单元格（与顶端固定死）
    self.icon.frame =self.layout.iconImageFrame;
    [self.contentView addSubview:self.icon];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.layout.model.avatar]];
    self.icon.layer.cornerRadius =20;
    self.icon.layer.masksToBounds =YES;

    //这里黄色头衔可能要调整下，毕竟icon被圆角了
    //暂时放子右下角好嘞
    
    for (NSString *iden in self.layout.model.daren_identity) {
        
        if ([iden isEqualToString:@"normal"]) {
            self.identity.hidden = YES;
        }
    }
    self.identity.frame = self.layout.vipImageFrame;
    [self.contentView addSubview:self.identity];
    
    self.identity.image = [UIImage imageNamed:@"verified_icon_L@2x.png"];
    
    
     //nameLabel   相对布局于单元格d
    self.username.frame = self.layout.nameFrame;
    [self.contentView addSubview:self.username];
    self.username.font = [UIFont systemFontOfSize:13];
    self.username.text = self.layout.model.username;
    
    //button在单元格的中间(也固定死)。并且有初始化值，
    //根据是否已经关注来确定初始化值
    self.attent.frame = CGRectMake(kScreenWidth-10-60, (self.layout.cellHeight-30)/2, 60, 30);
    [self.contentView addSubview:self.attent ];
    
    self.attent.layer.cornerRadius =5;
    if (self.layout.model.relationship == 0) {
        
        self.attent.backgroundColor = [UIColor colorWithRed:94/255.0 green:190/255.0 blue:50/255.0 alpha:1];
        [self.attent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.attent setTitle:@"关注" forState:UIControlStateNormal];
        [self.attent setFont:[UIFont systemFontOfSize:12]];
    }
 
    //自适应的(三个wxlabel)
    self.self_description.frame = self.layout.short_descriptionFrame;
    [self.contentView addSubview:self.self_description];
    self.self_description.text = self.layout.model.short_description;
    self.self_description.font = [UIFont systemFontOfSize:11];
    self.self_description.textColor= [UIColor grayColor];
    
    self.love.frame = self.layout.loveFrame;
    self.daren_description.frame = self.layout.daren_descriptionFrame;
    [self.contentView addSubview:self.love];
    [self.contentView addSubview:self.daren_description];
    self.love.font = [UIFont systemFontOfSize:11];
    self.daren_description.font = [UIFont systemFontOfSize:11];
    self.love.textColor= [UIColor grayColor];
    self.daren_description.textColor = [UIColor grayColor];
    
    NSString *loveStr = @"";
    
    for (NSString *str in self.layout.model.daren_tags) {
        loveStr = [NSString stringWithFormat:@"%@, %@",loveStr,str];
    }
    loveStr = [loveStr substringWithRange:NSMakeRange(1, loveStr.length-1)];
    loveStr = [NSString stringWithFormat:@"擅长领域：%@",loveStr];
    self.love.text =loveStr ;
    self.daren_description.text =self.layout.model.daren_description;

    //还有些莫名其妙的东西，有再添加好了
   self.grayView = [[UIView alloc]initWithFrame:CGRectMake(10, self.layout.cellHeight-1, kScreenWidth-10, 1)];
    _grayView.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    [self addSubview:_grayView];

}

@end
