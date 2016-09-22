//
//  ArticleTableView.h
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *articleLayout;

@end
