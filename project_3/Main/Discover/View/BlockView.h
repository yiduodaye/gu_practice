//
//  BlockView.h
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockView : UIView
@property (nonatomic,copy)NSString *target;
@property (nonatomic,copy)NSString *theme;
- (instancetype)initWithFrame:(CGRect)frame
                        image:(NSString *)image
                         tetx:(NSString *)text;
@end
