//
//  Advertise.h
//  project_3
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Advertise : NSObject


@property(nonatomic,copy)NSMutableArray *advArray;



+ (instancetype)sharedInstance;

- (NSString *)getAdvertitsText;

@end
