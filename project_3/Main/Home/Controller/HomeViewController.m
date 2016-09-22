//
//  HomeViewController.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"
#import "DataService.h"
#import "HomeModel.h"
#import "UIImageView+WebCache.h"
#import "HomeTableView.h"
#import "HomeLayout.h"
#import "WXRefresh.h"
#import "Advertise.h"

@interface HomeViewController () {
    
    NSInteger i;
    
}
    
@property (nonatomic, strong) NSMutableArray *homeList;
@property (nonatomic, strong) NSString *start;

@end

@implementation HomeViewController

- (NSString *)start {
    
    if (_start == nil) {
        _start = @"0";
    }
    
    return _start;
}

- (NSMutableArray *)homeList{
    
    
    if (_homeList == nil) {
        _homeList = [NSMutableArray array];
    }
    
    return _homeList;
}

//新增的
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Advertise sharedInstance];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _homeTableView.frame = CGRectMake(0, 0, kScreenWidth, 0);

    _homeTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;

    [self requestdata];
   
    [self _loadNavigationBarSubView];
    
    [_homeTableView addPullDownRefreshBlock:^{
        
        i = 1;
        self.start = @"0";
        [self requestdata];
    }];
    
    [_homeTableView addInfiniteScrollingWithActionHandler:^{
        
        i = 2;
        [self requestdata];
    }];
    
}

- (void)_loadNavigationBarSubView {
    
    self.navigationItem.title = @"每日精选";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:@"nav_icon_add_red@2x.png"] forState:UIControlStateNormal ];
    button.frame = CGRectMake(0, 0, 44,44);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem =rightButton;
}

- (void)requestdata{
    
    [DataService getHomeRequestWithNextStart:self.start Success:^(NSArray *result, NSString *nextStart) {

        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSDictionary *dic in result) {
            HomeModel *home = [[HomeModel alloc]init];
            
            self.start = nextStart;
            
            home.target = dic[@"target"];
            home.sDescription = dic[@"description"];
            home.sTitle = dic[@"stitle"];
            home.image_url = dic[@"image_url"];
            home.icon_url = dic[@"icon_url"];
            home.style = dic[@"style"];
            home.dynamic_info = dic[@"dynamic_info"];
            
            HomeLayout *layout = [[HomeLayout alloc] init];
            layout.home = home;
    
            [tempArr addObject:layout];
        }
        if (i == 0) {
            self.homeList = tempArr;
        } else if (i == 1) {
            self.homeList = tempArr;
            [self.homeTableView.pullToRefreshView stopAnimating];
        } else {
            [self.homeList addObjectsFromArray:tempArr];
            [self.homeTableView.infiniteScrollingView stopAnimating];
        }
        
        self.homeTableView.homeLayout = _homeList;
        [self.homeTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败：%@", error);
    }];
}

@end
