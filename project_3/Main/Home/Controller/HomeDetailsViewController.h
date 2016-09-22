//
//  HomeDetailsViewController.h
//  project_3
//
//  Created by Imagine on 16/9/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *html;

@property (strong, nonatomic) UIView *bottomView;

- (instancetype)initWithHtml:(NSString *)html;

@end
