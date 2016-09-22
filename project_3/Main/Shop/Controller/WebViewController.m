//
//  WebViewController.m
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WebViewController.h"
#import "Common.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (instancetype)initWithHtml:(NSString *)html {
    
    self = [self init];
    _html = html;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [_webView loadHTMLString:_html baseURL:nil];
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view.
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
