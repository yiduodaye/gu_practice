//
//  Advertise.m
//  project_3
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Advertise.h"
#import "DataService.h"

static Advertise *instance = nil;
@implementation Advertise


//做成单例

+ (instancetype)sharedInstance {
    
    //多线程加锁，保证创建实例的代码仅被一个线程调用
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
        
    }
    
    return instance;

    
}

- (instancetype)init{
    self =[super init];
    if (self) {
        
        _advArray = [NSMutableArray array];
        [DataService getAdvertiseRequestWithNextStart:nil Success:^(NSArray *result, NSString *start) {
    
            
            
            for (NSDictionary *dic in result) {
                
                NSString *target = dic[@"target"];
                NSString *image_url =dic[@"image_url"];
                NSString *stitle = dic[@"stitle"];
                NSString *description=dic[@"description"];
                
                NSDictionary *info_dic =@{
                                          @"target":target,
                                          @"image_url":image_url,
                                          @"stitle":stitle,
                                          @"description":description
                                          };
                
                
                [self.advArray addObject:info_dic];
                
                
                
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    return self;
    
}

//保证alloc init也生成唯一实例对象
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    //如果实例没有创建，则调用NSObject类的allocWithZone方法进行内存申请
    @synchronized(self) {
        if (instance == nil) {
            
            instance = [super allocWithZone:zone];
            
        }
    }
    
    
    return instance;
    
}

//copy-->copyWithZone

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
    
}




@end
