//
//  DetailsLayout.m
//  project_3
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailsLayout.h"
#import "DetailsModel.h"
#import "Common.h"
#import "WXLabel.h"

@implementation DetailsLayout


- (void)setModel:(DetailsModel *)model {
        
    _model =model;
    self.scrollViewHeight =0;
    
    CGFloat imageWidth = kScreenWidth-20;
    //imagewidth/self.w = imageheight/self.h
    CGFloat imgWidth =[self.model.imgWidth floatValue];
    CGFloat imgHeight = [self.model.imgHeight floatValue];
    CGFloat imageHeight =(imageWidth *imgHeight)/imgWidth;
    //主图与顶端空隙
    self.scrollViewHeight +=10;
    
    self.imageFrame =CGRectMake(10, 10, imageWidth, imageHeight);
    
    self.scrollViewHeight +=self.imageFrame.size.height;
    
   CGFloat msgHeight =[WXLabel getTextHeight:14 width:imageWidth-20 text:self.model.msg];
    //与label的间距上下为10
    self.msgFrame=CGRectMake(10, 10+self.imageFrame.size.height, imageWidth, msgHeight+40);
    
    //
    self.scrollViewHeight +=self.msgFrame.size.height;
    
    self.titleFrame =CGRectMake(10, 10+self.imageFrame.size.height+self.msgFrame.size.height, imageWidth, 30);
    self.scrollViewHeight +=self.titleFrame.size.height;
    
    if (self.model.source_shortcut_icon ==nil || self.model.source_title ==nil) {
        self.titleFrame = CGRectMake(0, 0, 0, 0);
    }
    
    //用到自适应按钮，还是边框间隙为10
    
    CGFloat lenght = 10;
    for (NSString *tag in self.model.tags) {
        
        NSString *str =@"#";
        str = [str stringByAppendingString:tag];
        
        CGSize btnTextWidth = [self getLabelRectFromString:str  andFont:14];
        //加前后距离
        CGFloat btnWidth = btnTextWidth.width+20;
        
        lenght +=btnWidth+10;
        
        
        
    }
    if (self.model.tags.count ==0) {
        self.tagsFrame=CGRectMake(0, 0, 0, 0);
    }
    
    else if (lenght < imageWidth){
        //按钮的高度为30
        CGFloat btnHeight =30;
        self.tagsFrame=CGRectMake(10,10+self.imageFrame.size.height+self.titleFrame.size.height+self.msgFrame.size.height, imageWidth, 10+10+btnHeight);
        
    }
    else {
        
        //只显示2排tags
        CGFloat btnHeight =30;
        self.tagsFrame=CGRectMake(10,10+self.imageFrame.size.height+self.titleFrame.size.height+self.msgFrame.size.height, imageWidth, 10+10+btnHeight+10+btnHeight);
        
    }
    
    
    self.scrollViewHeight +=self.tagsFrame.size.height;
    
    self.userFrame=CGRectMake(10, 10+self.imageFrame.size.height+self.msgFrame.size.height+self.titleFrame.size.height+self.tagsFrame.size.height, imageWidth, 50);
    
    self.scrollViewHeight +=self.userFrame.size.height;
    
    
    //view1完成
    //灰色间隙.view1与view2的
    self.scrollViewHeight +=15;
    //攒区高度110（label:50;头像:60）
    self.favourateFrame = CGRectMake(10, 10+self.imageFrame.size.height+self.msgFrame.size.height+self.titleFrame.size.height+self.tagsFrame.size.height+self.userFrame.size.height+15, imageWidth, 110);
    
    if (self.model.top_like_users.count==0) {
        self.favourateFrame=CGRectMake(0, 0, 0, 0);
    }
  
    //view2完成30/80
    self.scrollViewHeight +=15;
    
    self.albumFrame=CGRectMake(10,  10+self.imageFrame.size.height+self.msgFrame.size.height+self.titleFrame.size.height+self.tagsFrame.size.height+self.userFrame.size.height+15+self.favourateFrame.size.height+15, imageWidth, 30+120);
    
    self.scrollViewHeight +=self.albumFrame.size.height;
    
    //view3完成
    //这个是透明的
    self.lineFrame =CGRectMake(10,  10+self.imageFrame.size.height+self.msgFrame.size.height+self.titleFrame.size.height+self.tagsFrame.size.height+self.userFrame.size.height+15+self.favourateFrame.size.height+15+self.albumFrame.size.height, imageWidth, 40);
    
    self.scrollViewHeight +=self.lineFrame.size.height;
    
    //分割线完成
    //view4是广告
    
    self.advertiseFrame =CGRectMake(10,10+self.imageFrame.size.height+self.msgFrame.size.height+self.titleFrame.size.height+self.tagsFrame.size.height+self.userFrame.size.height+15+self.favourateFrame.size.height+15+self.albumFrame.size.height+self.lineFrame.size.height , imageWidth, 200);
    
    self.scrollViewHeight +=self.advertiseFrame.size.height;
    
    
    
}

//计算文本宽度
- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
}

@end
