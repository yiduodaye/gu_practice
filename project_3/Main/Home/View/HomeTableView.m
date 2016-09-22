//
//  HomeTableView.m
//  project_3
//
//  Created by Imagine on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeLayout.h"
#import "HomeCell.h"
#import "Common.h"
#import "HomeDetailsViewController.h"

@implementation HomeTableView {
    
    UIWebView *_webView;
}

- (void)awakeFromNib{
    self.dataSource = self;
    self.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeLayout *layout = self.homeLayout[indexPath.row];
    
    return layout.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.homeLayout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    
    cell.layout = self.homeLayout[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeLayout *layout = _homeLayout[indexPath.row];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scalesPageToFit =YES;
    _webView.delegate = self;
    
    NSURL *url = nil;
    
    NSInteger start= [layout.home.target rangeOfString:@"h"].location;
    if (start == 0) {
        url =[[NSURL alloc] initWithString:layout.home.target];
    } else {

        NSInteger start = [layout.home.target rangeOfString:@":" options:NSBackwardsSearch].location;
        
        NSString *str = [layout.home.target substringWithRange:NSMakeRange(start - 4, layout.home.target.length - start + 4)];
        
        url =[[NSURL alloc] initWithString:str];
    }
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    
    [_webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
    HomeDetailsViewController *webView2 = [[HomeDetailsViewController alloc] initWithHtml:HTMLSource];
    
    [self getViewController].hidesBottomBarWhenPushed = YES;
    [[self getViewController].navigationController pushViewController:webView2 animated:YES];
    [self getViewController].hidesBottomBarWhenPushed = NO;
}

- (UIViewController *)getViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
