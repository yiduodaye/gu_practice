//
//  DetailsLayout.h
//  project_3
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DetailsModel;
@interface DetailsLayout : NSObject

@property(nonatomic,strong)DetailsModel *model;

@property(nonatomic,assign)CGFloat scrollViewHeight;

@property(nonatomic,assign)CGRect imageFrame;
@property(nonatomic,assign)CGRect msgFrame;
@property(nonatomic,assign)CGRect titleFrame;
@property(nonatomic,assign)CGRect tagsFrame;
@property (nonatomic,assign)CGRect userFrame;

@property(nonatomic,assign)CGRect view1Frame;

@property(nonatomic,assign)CGRect favourateFrame;
@property(nonatomic,assign)CGRect albumFrame;
@property(nonatomic,assign)CGRect lineFrame;
@property(nonatomic,assign)CGRect advertiseFrame;


@end
