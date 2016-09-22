//
//  SearchTableViewController.h
//  project_3
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *Cv;
//请求数据的时候。。需要递交的参数。
@property (nonatomic,copy)NSString *condition;
@end
