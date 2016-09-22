//
//  AccountManagerViewController.m
//  project_3
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AccountManagerViewController.h"

@interface AccountManagerViewController ()

@end

@implementation AccountManagerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:255/255.0 alpha:1];
}

- (void)_setBackBarButton{
    
    //隐藏自带的
    self.navigationItem.hidesBackButton =YES;
    
    
    //自定义左侧按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 30, 30);
    //   button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"icon-back_highlighted@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem =backButton;
    
    
}



@end
