//
//  DiscoverFooterView.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverFooterView.h"
#import "Common.h"
#import "Advertise.h"
#import "UIImageView+WebCache.h"

@implementation DiscoverFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    if (self) {
        self.width =kScreenWidth;
        self.height =200;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addAdvertistView];
        
    }
    return self;
}

- (void)addAdvertistView{
    
    Advertise *adv=[Advertise sharedInstance];
    
    UIImageView *advView = [[UIImageView alloc] initWithFrame:self.frame];
    
#warning this is a problem这里老是要崩溃
// ?????????有时候广告没请求回来， 就设置是不行的
    NSInteger adv_number = arc4random()%(adv.advArray.count-1);

    NSDictionary *adv_dic = adv.advArray[adv_number];
    [advView sd_setImageWithURL:[NSURL URLWithString:adv_dic[@"image_url"]]];
    [self addSubview:advView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.width-5, 15)];
    label.text =adv_dic[@"stitle"];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    
}
@end
