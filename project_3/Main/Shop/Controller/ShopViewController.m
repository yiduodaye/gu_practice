//
//  ShopViewController.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShopViewController.h"
#import "UIImageView+WebCache.h"
#import "ShopTableView.h"
#import "Common.h"
#import "DataService.h"
#import "TopModel.h"
#import "ShopCellModel.h"
#import "ShopCellLayout.h"
#import "WXRefresh.h"
#import "WebViewController.h"

@interface ShopViewController ()

@property (nonatomic, strong) NSMutableArray *shopTopList;
@property (nonatomic, strong) NSMutableArray *shopCellList;

@end

@implementation ShopViewController

- (NSMutableArray *)shopTopList{
    
    
    if (_shopTopList == nil) {
        _shopTopList = [NSMutableArray array];
    }
    
    return _shopTopList;
}

- (NSMutableArray *)shopCellList{
    
    
    if (_shopCellList == nil) {
        _shopCellList = [NSMutableArray array];
    }
    
    return _shopCellList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _shopTableView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    
    _shopTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self _loadNavigationBarSubView];
    
    [self _loadShopTopData];
    
    [self _loadShopCellData];
    
    [self _loadGift];
    
    [_shopTableView addPullDownRefreshBlock:^{

        [self _loadShopTopData];
        [self _loadShopCellData];
    }];
}

- (void)_loadNavigationBarSubView {
    
    self.navigationItem.title = @"堆糖商店";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftButton setImage:[UIImage imageNamed:@"lefticon.png"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 32, 32);
    UIBarButtonItem *lButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = lButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setImage:[UIImage imageNamed:@"righticon.png"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 32, 32);
    UIBarButtonItem *rButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rButton;
}

- (void)_loadShopTopData {
    
    [DataService getShopTopRequestWithNextStart:nil Success:^(NSArray *result, NSString *start) {
        
        TopModel *topModel = [[TopModel alloc] init];

        topModel.start = start;
        topModel.array = [[NSMutableArray alloc] initWithArray:result];

        [self.shopTopList removeAllObjects];
        
        [self.shopTopList addObject:topModel];
        
        self.shopTableView.shopTopLayout = _shopTopList;
        [self.shopTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)_loadShopCellData {
    
    [DataService getShopCellRequestWithNextStart:nil Success:^(NSArray *result, NSString *start) {
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSDictionary *dic in result) {
            ShopCellModel *cellModel = [[ShopCellModel alloc]init];
            
            cellModel.sDescription = dic[@"description"];
            cellModel.sTitle = dic[@"stitle"];
            cellModel.image_url = dic[@"image_url"];
            cellModel.target = dic[@"target"];
       
            ShopCellLayout *layout = [[ShopCellLayout alloc] init];
            layout.cellModel = cellModel;
            
            [tempArr addObject:layout];
        }

        self.shopCellList = tempArr;

        [self.shopTableView.pullToRefreshView stopAnimating];
        
        self.shopTableView.shopCellLayout = _shopCellList;
        [self.shopTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)_loadGift {
    
    UIImageView *gift = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 12 / 16, kScreenHeight - kScreenWidth * 1 / 4 - 110, kScreenWidth * 3 / 16, kScreenWidth * 3 / 16)];
    gift.backgroundColor = [UIColor clearColor];
    gift.image = [UIImage imageNamed:@"xinren.png"];
    
    [self.view addSubview:gift];
}

@end
