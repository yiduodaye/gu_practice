//
//  AccountSafetyViewController.m
//  project_3
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AccountSafetyViewController.h"
#import "Common.h"
@interface AccountSafetyViewController ()

@end

@implementation AccountSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    self.navigationItem.title = @"账号与安全";
    [self _setBackBarButton];
    [self _loadSubView];
}


- (void)_loadSubView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, 40*2)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 25/2, 120, 15)];
    label1.text =@"绑定新浪微博";
    label1.font = [UIFont systemFontOfSize:14];
    [view addSubview:label1];
    
    UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth -10-50, 5, 50, 30)];
    [view addSubview:switch1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 39, kScreenWidth-10, 1)];
    lineView1.backgroundColor = self.view.backgroundColor;
    [view addSubview:lineView1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, lineView1.bottom+25/2, 120, 15)];
    label2.text =@"绑定QQ";
    label2.font = [UIFont systemFontOfSize:14];
    [view addSubview:label2];
    
    UISwitch *switch2 = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth -10-50,lineView1.bottom +5, 50, 30)];
    [view addSubview:switch2];

    //****************************
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 25+view.bottom, kScreenWidth, 40*2)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 25/2, 120, 15)];
    label3.text =@"绑定邮箱";
    label3.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:label3];
    
    UILabel *label_3 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-10-50, 25/2, 50, 15)];
    label_3.text =@"未绑定";
    label_3.textAlignment = NSTextAlignmentRight;
    label_3.textColor =self.view.backgroundColor ;
    label_3.font = [UIFont systemFontOfSize:13];
    [view2 addSubview:label_3];
    
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 39, kScreenWidth-10, 1)];
    lineView2.backgroundColor = self.view.backgroundColor;
    [view2 addSubview:lineView2];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, lineView2.bottom +25/2, 120, 15)];
    label4.text = @"绑定手机";
    label4.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:label4];
    
    UILabel *label_4 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-10-80, lineView2.bottom+25/2, 80, 15)];
    label_4.text =@"135****333";
    label_4.textAlignment = NSTextAlignmentRight;
    label_4.textColor = [UIColor blackColor];
    label_4.font = [UIFont systemFontOfSize:13];
    [view2 addSubview:label_4];
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

- (void)backToController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
