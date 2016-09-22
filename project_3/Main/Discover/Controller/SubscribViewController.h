//
//  SubscribViewController.h
//  project_3
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *Cv;
@property (nonatomic,copy)NSString *condition;
@property (nonatomic,copy)NSString *theme;

@end
