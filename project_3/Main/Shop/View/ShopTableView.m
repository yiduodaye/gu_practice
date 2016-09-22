//
//  ShopTableView.m
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopTableView.h"
#import "Common.h"
#import "ShopCell.h"
#import "ShopTopCell.h"
#import "ShopMidCell.h"
#import "WebViewController.h"
#import "ShopViewController.h"
#import "AppDelegate.h"

@implementation ShopTableView {
    
    UIWebView *_webView;
    
}

- (void)awakeFromNib{
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return self.shopCellLayout.count;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
   
        return kScreenWidth * 35 / 64 + 2 * (kScreenWidth / 4 - 10) + kScreenWidth / 2 + 20;
    } else if (indexPath.section == 1) {
        
        return kScreenWidth / 2.2 + kScreenWidth / 6;
        
    } else {
        ShopCellLayout *layout = _shopCellLayout[indexPath.row];
        
        return layout.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {

        ShopTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopTopCell"];
        if (!cell) {
            cell = [[ShopTopCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"shopTopCell"];
        }

        cell.topModel = _shopTopLayout[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        ShopMidCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopMidCell"];
        if (!cell) {
            cell = [[ShopMidCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"shopMidCell"];
        }
        [cell awakeFromNib];
        return cell;
    }

    else {
        ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
        if (cell == nil) {
            cell = [[ShopCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"shopCell"];
        }
        
        cell.layout = _shopCellLayout[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        label1.text =    @"会 员 折 扣";
        label2.text = @"－                        －";
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:16];
        label2.font = [UIFont systemFontOfSize:15];
        label1.alpha = .85;
        label2.alpha = .35;
        [view addSubview:label1];
        [view addSubview:label2];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 10)];
        label1.text =    @"专 题";
        label2.text = @"－               －";
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:16];
        label2.font = [UIFont systemFontOfSize:15];
        label1.alpha = .85;
        label2.alpha = .35;
        [view addSubview:label1];
        [view addSubview:label2];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return kScreenHeight / 10;
    } else if (section == 2) {
        return kScreenHeight / 10;
    }
    
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 10 / 568)];

    view.backgroundColor = [UIColor grayColor];
    view.alpha = .1;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return kScreenHeight * 10 / 568;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        ShopCellLayout *layout = _shopCellLayout[indexPath.row];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scalesPageToFit =YES;
        _webView.delegate = self;
        
        NSURL *url =[[NSURL alloc] initWithString:layout.cellModel.target];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];

    NSLog(@"%@",HTMLSource);
    
    WebViewController *webView2 = [[WebViewController alloc] initWithHtml:HTMLSource];
    [[self getViewController].navigationController pushViewController:webView2 animated:YES];
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
