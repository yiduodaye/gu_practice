//
//  MyselfViewController.m
//  project_3
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyselfViewController.h"
#import "Common.h"
#define imgHeight 220

@interface MyselfViewController (){
    UILabel *fansLabel;
    UILabel *reduceLabel;
    UILabel *locationLabel;
    UILabel *starLabel;
    UILabel *nameLabel;
    UIImageView *icon;
}

@end

@implementation MyselfViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     [self _loadSubView];
    
   // self.navigationController.navigationBar.translucent=YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}


-(void)_loadSubView{
    
    //增加一个欢动视图
    UIScrollView *sView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    sView.backgroundColor =[UIColor whiteColor];
    sView.contentSize=CGSizeMake(0, kScreenHeight);
    [self.view addSubview:sView];
    sView.scrollEnabled=YES;
    sView.delegate=self;
    sView.showsVerticalScrollIndicator=NO;
    sView.showsHorizontalScrollIndicator=NO;
   _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 220)];
    _imgView.image = [UIImage imageNamed:@"cat.jpg"];
    [sView addSubview:_imgView];
    
    UIButton *backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(15, 25, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"icon_back_light@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kScreenWidth-10-25, backBtn.top, 25, 25);
    [self.view addSubview:moreBtn];
    [moreBtn setImage:[UIImage imageNamed:@"icon_more_light@2x.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreTo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    fansLabel= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, _imgView.bottom-50, 100, 10)];
    fansLabel.textColor=[UIColor whiteColor];
    fansLabel.text=@"关注 3·粉丝 0";
    fansLabel.textAlignment=NSTextAlignmentCenter;
    fansLabel.font=[UIFont systemFontOfSize:10];
    [self.imgView addSubview:fansLabel];
    
    
    reduceLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.imgView.width-100)/2, fansLabel.bottom-10-10, 100, 10)];
    reduceLabel.textAlignment=NSTextAlignmentCenter;
    reduceLabel.textColor=[UIColor whiteColor];
    reduceLabel.text=@"天要下雨";
    reduceLabel.font = [UIFont systemFontOfSize:10];
    [self.imgView addSubview:reduceLabel];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.imgView.width-100)/2, reduceLabel.bottom-10-10, 100, 10)];
    locationLabel.text=@"浙江 杭州";
    locationLabel.textColor= [UIColor whiteColor];
    locationLabel.textAlignment=NSTextAlignmentCenter;
    locationLabel.font =[UIFont systemFontOfSize:10];
    [self.imgView addSubview:locationLabel];
    
    starLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.imgView.width-100)/2, locationLabel.bottom-10-10, 100, 10)];
    starLabel.text=@"1";
    starLabel.textColor= [UIColor whiteColor];
    starLabel.textAlignment=NSTextAlignmentCenter;
    starLabel.font =[UIFont systemFontOfSize:10];
    [self.imgView addSubview:starLabel];

    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.imgView.width-100)/2, starLabel.bottom-20-10, 100, 10)];
    nameLabel.text=@"Catherine";
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.font=[UIFont systemFontOfSize:14];
    [self.imgView addSubview:nameLabel];
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.imgView.width-50)/2, nameLabel.bottom-20-50, 50, 50)];
    icon.image=[UIImage imageNamed:@"icon_Club_users@3x.png"];
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.cornerRadius=25;
    icon.layer.masksToBounds=YES;
    [self.imgView addSubview:icon];
    
    
    
    
    
    
    
    
    
    
    UILabel *showLabel=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120)/2, _imgView.height+120, 120, 15)];
    showLabel.text =@"这里还没有内容";
    showLabel.textColor=[UIColor grayColor];
    [sView addSubview:showLabel];
    
    
    
}

- (void)backTo:(UIButton *)btn{
    
  
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    
}

- (void)moreTo:(UIButton *)btn{
    
    NSLog(@"PUSH");
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取y 轴唯一
    //self.automaticallyAdjustsScrollViewInsets=NO;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //先判断下是向上还是向下滑动。不同的方向触发不同事件
    
    //由于布局的问题，自己已经先向上偏移了-20
    
    if (offsetY > -20){
        //向上滑动时
        _imgView.top = -(offsetY+20);
        CGFloat alphas=1-offsetY/25.0;
        if (alphas <0) {
            alphas =0;
        }
        fansLabel.alpha=alphas;
        reduceLabel.alpha=alphas;
        locationLabel.alpha=alphas;
        starLabel.alpha=alphas;
        nameLabel.alpha=alphas;
        icon.alpha=alphas;
        
        
    }
    else {
        //计算
        CGFloat heigth = ABS(offsetY+20) +imgHeight;
        CGFloat width = kScreenWidth/imgHeight*heigth;
        CGRect frame = CGRectMake(-(width-kScreenWidth)/2, 0-ABS(offsetY), width, heigth);
        _imgView.frame = frame;
       
    }
    fansLabel.frame=CGRectMake((self.imgView.width-100)/2, self.imgView.bottom-50-offsetY, 100, 10);
    reduceLabel.frame=CGRectMake((self.imgView.width-100)/2, fansLabel.bottom-10-10, 100, 10);
    locationLabel.frame=CGRectMake((self.imgView.width-100)/2, reduceLabel.bottom-10-10, 100, 10);
    starLabel.frame=CGRectMake((self.imgView.width-100)/2, locationLabel.bottom-10-10, 100, 10);
    nameLabel.frame=CGRectMake((self.imgView.width-100)/2, starLabel.bottom-20-10, 100, 10);
    icon.frame=CGRectMake((self.imgView.width-50)/2, nameLabel.bottom-20-50, 50, 50);
}

@end
