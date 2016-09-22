//
//  PersonageViewController.h
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonageTableView;
@interface PersonageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet PersonageTableView *tableView;


@end
