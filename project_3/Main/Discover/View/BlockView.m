//
//  BlockView.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BlockView.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@implementation BlockView

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image tetx:(NSString *)text {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.width =kScreenWidth/2;
        self.height = 60;
        
      UIImageView  *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        imgView.contentMode =UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:image]];
      
        
        
       UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+8, imgView.top+10, 80, 20)];
        
        [self addSubview:label];
        label.text =text;
        label.font = [UIFont systemFontOfSize:14];
        
       
    }
    
    
    return self;
    
}


    

    


@end
