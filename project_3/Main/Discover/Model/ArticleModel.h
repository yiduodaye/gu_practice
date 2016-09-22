//
//  ArticleModel.h
//  project_3
//
//  Created by Imagine on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArticleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *photo_path;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *dynamic_info;

@end
