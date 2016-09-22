//
//  InputView.h
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView


@property(nonatomic,strong)UITextField *text;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIView *line;
@property (nonatomic,assign)BOOL pwd;
- (instancetype)initWithFrame:(CGRect)frame ispassword:(BOOL)pwd;

@end
