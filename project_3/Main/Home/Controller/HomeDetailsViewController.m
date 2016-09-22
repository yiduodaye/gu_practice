//
//  HomeDetailsViewController.m
//  project_3
//
//  Created by Imagine on 16/9/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "Common.h"

@interface HomeDetailsViewController ()

@end

@implementation HomeDetailsViewController

- (instancetype)initWithHtml:(NSString *)html {
    
    self = [self init];
    _html = html;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [_webView loadHTMLString:_html baseURL:nil];
    
    CGFloat y = kScreenHeight - 119;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 55)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    [self _loadButton];
  
    [self.view addSubview:_webView];
    [self.view addSubview:_bottomView];
    // Do any additional setup after loading the view.
}

- (void)_loadButton {
    
    UIButton *star = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 3, 45)];
    [star setImage:[UIImage imageNamed:@"detail_icon_star@2x.png"] forState:UIControlStateNormal];
    UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, kScreenWidth / 3, 15)];
    starLabel.text = @"收藏";
    starLabel.font = [UIFont systemFontOfSize:10];
    starLabel.alpha = .6;
    starLabel.textAlignment = NSTextAlignmentCenter;
    [star addSubview:starLabel];
    
    UIButton *good = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(star.frame), 0, kScreenWidth / 3, 45)];
    [good setImage:[UIImage imageNamed:@"detail_action_icon_good@2x.png"] forState:UIControlStateNormal];
    UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, kScreenWidth / 3, 15)];
    goodLabel.text = @"赞";
    goodLabel.font = [UIFont systemFontOfSize:10];
    goodLabel.alpha = .6;
    goodLabel.textAlignment = NSTextAlignmentCenter;
    [good addSubview:goodLabel];
    
    UIButton *comment = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(good.frame), 0, kScreenWidth / 3, 45)];
    [comment setImage:[UIImage imageNamed:@"detail_action_icon_comment@2x.png"] forState:UIControlStateNormal];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, kScreenWidth / 3, 15)];
    commentLabel.text = @"评论";
    commentLabel.font = [UIFont systemFontOfSize:10];
    commentLabel.alpha = .6;
    commentLabel.textAlignment = NSTextAlignmentCenter;
    [comment addSubview:commentLabel];

    [_bottomView addSubview:star];
    [_bottomView addSubview:good];
    [_bottomView addSubview:comment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
