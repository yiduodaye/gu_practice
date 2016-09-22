//
//  PersonageFooterView.m
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonageFooterView.h"
#import "Common.h"
@implementation PersonageFooterView{
    NSArray *imageArray;
    NSArray *labelNameArray;
    NSArray *fontArray;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.frame= CGRectMake(0, 0, kScreenWidth, 70);
        
        imageArray = @[@"icon_me_wait_pay@2x.png",@"icon_me_wait_send@2x.png",@"icon_me_wait_receive@2x.png"];
        labelNameArray =@[@"待付款",@"待发货",@"待收货"];
        fontArray = [UIFont familyNames];
        [self _loadSubView];
    
    }
    return self;
}

- (void)_loadSubView{
    
  CGFloat  viewWidth = kScreenWidth/3;
    
    for (NSInteger i =0; i<3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*viewWidth+4, 0, viewWidth, self.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake((view.width -30)/2, 10, 30, 30)];
       ImgView.image =[UIImage imageNamed:imageArray[i]];
        
        [view addSubview:ImgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((view.width -50)/2, ImgView.bottom+10, 50, 10)];
        label.text = labelNameArray[i];
        label.textAlignment =NSTextAlignmentCenter;
        
        label.font =[UIFont fontWithName:fontArray[35] size:12];
        [view addSubview:label];
        [self addSubview:view];
        
    }
    
    
}

@end
