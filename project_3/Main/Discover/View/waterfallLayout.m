//
//  waterfallLayout.m
//  project_3
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "waterfallLayout.h"
#define kCellWidth (kScreenWidth-40)/2
#import "Common.h"
#import "WXLabel.h"

@implementation waterfallLayout

- (void)setCellModel:(CellModel *)cellModel {
    _cellModel =cellModel;
    self.cellHeight =0;
    
    //图片高度计算

    CGFloat imgHeight =( kCellWidth * self.cellModel.imgHeight)/self.cellModel.imgWidth;
    //宽/140 = 高/imgView.height
    
    
    self.imgFrame = CGRectMake(0, 0, kCellWidth, imgHeight);
    
    self.cellHeight += self.imgFrame.size.height;
    
    
    //价格标签

    self.priceLabelFrame = CGRectMake(self.imgFrame.size.width-35, self.imgFrame.size.height -15  ,35, 15);
    
    
    //文正自适应
    
    CGFloat textHeigth =[WXLabel getTextHeight:10 width:kCellWidth-20 text:self.cellModel.msg];

    if (textHeigth > 70) {
       self.textFrame = CGRectMake(10, self.imgFrame.size.height+5, kCellWidth -20, 66);
    }
    else{
            self.textFrame = CGRectMake(10, self.imgFrame.size.height+5, kCellWidth -20, textHeigth);
    }
  
    self.cellHeight +=5;//大图和正文间隙
    self.cellHeight += CGRectGetHeight(self.textFrame);
    self.cellHeight +=10;//正文和按钮栏的间隙
    
   
    self.shopImgaeViewFrame = CGRectMake(kCellWidth-20-20, self.imgFrame.size.height+5+self.textFrame.size.height+5, 20, 20);
     //图标1
    self.imageViewFrame_1 = CGRectMake(10,self.imgFrame.size.height+5+self.textFrame.size.height+10 ,10, 10);
    //标签1
    
    NSString *count1 =[NSString stringWithFormat:@"%ld",self.cellModel.reply_count];
    
    CGSize labelSize_1 =[self getLabelRectFromString:count1 andFont:8];
    self.labelFrame_1 = CGRectMake(10+self.imageViewFrame_1.size.width+3, self.imgFrame.size.height+5+self.textFrame.size.height+10, labelSize_1.width, 10);
    //图标2
    self.imgaeViewFrame_2 = CGRectMake(10+self.imageViewFrame_1.size.width+3+self.labelFrame_1.size.width+3, self.imgFrame.size.height+5+self.textFrame.size.height+10, 10, 10);
    //标签2
       NSString *count2 =[NSString stringWithFormat:@"%ld",self.cellModel.like_count];
    CGSize labelSize_2 =[self getLabelRectFromString:count2 andFont:8];
    self.labelFrame_2 = CGRectMake(10+self.imageViewFrame_1.size.width+3+self.labelFrame_1.size.width+3+self.imgaeViewFrame_2.size.width+3, self.imgFrame.size.height+5+self.textFrame.size.height+10, labelSize_2.width, 10);
    
    //图片3
       self.imageViewFrame_3 = CGRectMake(10+self.imageViewFrame_1.size.width+3+self.labelFrame_1.size.width+3+self.imgaeViewFrame_2.size.width+3+self.labelFrame_2.size.width+3, self.imgFrame.size.height+5+self.textFrame.size.height+10, 10, 10);
    //标签3
       NSString *count3 =[NSString stringWithFormat:@"%ld",self.cellModel.favorite_count];
    CGSize labelSize_3 =[self getLabelRectFromString:count3 andFont:8];
    self.labelFrame_3 = CGRectMake(10+self.imageViewFrame_1.size.width+3+self.labelFrame_1.size.width+3+self.imgaeViewFrame_2.size.width+3+self.labelFrame_2.size.width+3+ self.imageViewFrame_3.size.width+3, self.imgFrame.size.height+5+self.textFrame.size.height+10, labelSize_3.width, 10);
    
    
    self.cellHeight +=self.imageViewFrame_1.size.height;//按钮栏高度
    self.cellHeight +=10;//按钮栏与用户信息视图间隙
    
    self.iconImageFrame = CGRectMake(10, 10, 30, 30);
    CGFloat nameHeight = [WXLabel getTextHeight:12 width:kCellWidth -10 -30-5-5 text:self.cellModel.name];
    self.nameLabelFrame = CGRectMake(10+30+5, 10, kCellWidth -10 -30-5-5, nameHeight);
    
    CGFloat usernameHeight = [WXLabel getTextHeight:10 width:kCellWidth -10 -30-5-5 text:[NSString stringWithFormat:@"by %@",self.cellModel.username]];
    self.usernameLabelFrame=CGRectMake(10+30+5, 10+5+self.nameLabelFrame.size.height, kCellWidth -10 -30-5-5,usernameHeight);
    
    
    self.userViewFrame =CGRectMake(0, self.cellHeight, kCellWidth, 10+self.nameLabelFrame.size.height+5+self.usernameLabelFrame.size.height+10);
    
    
    
    
    
    
    
    
    
    self.cellHeight +=self.userViewFrame.size.height;//用户信息视图
    //self.cellHeight +=10;//视图与底边间隙
    
    
    
    
    
    
    
    
}

- (CGSize )getTempSizeForLabel:(UILabel *)label {
    
    //设置字体
    //UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:24.0f];
    UIFont *fnt = [UIFont systemFontOfSize:8];
    label.font =fnt;
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    return size;
    
}

- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
}


@end
