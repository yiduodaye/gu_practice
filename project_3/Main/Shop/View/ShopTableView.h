//
//  ShopTableView.h
//  project_3
//
//  Created by Imagine on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopTableView : UITableView <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *shopCellLayout;
@property (nonatomic, strong) NSMutableArray *shopTopLayout;

@end
