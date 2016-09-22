//
//  AboutViewController.m
//  project_3
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AboutViewController.h"
#import "Common.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    self.navigationItem.title = @"关于我们";
    [self _setBackBarButton];
    [self _loadSubView];
}

- (void)_loadSubView{
    
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 64+40, 60, 60)];
    [self.view addSubview:logoView];
    logoView.image  = [UIImage imageNamed:@"set_logo@2x.png"];
    
    UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, logoView.bottom+10, 100, 10)];
    label1.textColor= [UIColor grayColor];
    label1.alpha = .8;
    label1.text = @"© 2016 duitang.com";
    label1.font = [UIFont systemFontOfSize:10];
    label1.textAlignment =  NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel *label2= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, label1.bottom+4, 100, 10)];
    label2.textColor= [UIColor grayColor];
    label2.alpha = .8;
    label2.text = @"版本 6.4.0(165778)";
    label2.font = [UIFont systemFontOfSize:10];
    label2.textAlignment =  NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    UILabel *label3= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, label2.bottom+4, 100, 10)];
    label3.textColor= [UIColor grayColor];
    label3.alpha = .8;
    label3.text = @"代码（583bf5）";
    label3.font = [UIFont systemFontOfSize:10];
    label3.textAlignment =  NSTextAlignmentCenter;
    [self.view addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, label3.bottom+20, kScreenWidth-15, 15)];
    label4.text =@"堆糖是一个以美好生活为主题的图片分享社区。";
    
    label4.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label4];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, label4.bottom+50, kScreenWidth, kScreenHeight-(label4.bottom+50))];
    view2.backgroundColor =  [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.05];
    [self.view addSubview:view2];
    
    UIView *versionView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 30)];
    versionView.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:versionView];
    
    UILabel *reduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15/2, 120, 15)];
    reduceLabel.text = @"版本介绍6.4.0";
    reduceLabel.textAlignment =NSTextAlignmentCenter;
    reduceLabel.font = [UIFont systemFontOfSize:15];
    [versionView addSubview: reduceLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(versionReduce:)];
    [versionView addGestureRecognizer:tap];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20-20, 5, 20, 20)];
    imgView.image = [UIImage imageNamed:@"icon-forward_highlighted@2x"];
    [versionView addSubview:imgView];
    
    
}

- (void)versionReduce:(UITapGestureRecognizer *)tap{

    NSLog(@"那就版本介绍咯");
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
- (void)backToController {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
