//
//  ArticleViewController.m
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArticleViewController.h"
#import "Common.h"
#import "DataService.h"
#import "ArticleModel.h"
#import "ArticleLayout.h"
#import "WXRefresh.h"

@interface ArticleViewController () {
    
    NSInteger i;
    
}
    
@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, strong) NSString *start;

@end

@implementation ArticleViewController

- (NSString *)start {
    
    if (_start == nil) {
        _start = @"0";
    }
    
    return _start;
}

- (NSMutableArray *)articleList{
    
    if (_articleList == nil) {
        _articleList = [NSMutableArray array];
    }
    
    return _articleList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"文章";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _articleTableView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    
    _articleTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    [self requestdata];
    
    [_articleTableView addPullDownRefreshBlock:^{
        
        i = 1;
        self.start = @"0";
        [self requestdata];
    }];
    
    [_articleTableView addInfiniteScrollingWithActionHandler:^{
        
        i = 2;
        [self requestdata];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)requestdata{
    
    [DataService getArticleRequestWithNextStart:self.start Success:^(NSArray *result, NSString *nextStart) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSDictionary *dic in result) {
            ArticleModel *article = [[ArticleModel alloc]init];
            
            self.start = nextStart;
            
            article.title = dic[@"title"];
            article.content = dic[@"content"];
            NSDictionary *_dic = [[NSDictionary alloc] init];
            _dic = dic[@"cover"];
            article.photo_path = _dic[@"photo_path"];
            article.icon_url = dic[@"icon_url"];
            article.dynamic_info = dic[@"dynamic_info"];
            
            ArticleLayout *layout = [[ArticleLayout alloc] init];
            layout.article = article;
            
            [tempArr addObject:layout];
        }
        if (i == 0) {
            self.articleList = tempArr;
        } else if (i == 1) {
            self.articleList = tempArr;
            [self.articleTableView.pullToRefreshView stopAnimating];
        } else {
            [self.articleList addObjectsFromArray:tempArr];
            [_articleTableView.infiniteScrollingView stopAnimating];
        }
        
        _articleTableView.articleLayout = _articleList;
        [_articleTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败：%@", error);
    }];
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
