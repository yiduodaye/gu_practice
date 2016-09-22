//
//  HomeTableView.h
//  project_3
//
//  Created by Imagine on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *homeLayout;

@end
