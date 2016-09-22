//
//  DataService.h
//  ImagineWeibo
//
//  Created by Imagine on 16/8/13.
//  Copyright © 2016年 Imagine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSArray *result, NSString *start);
typedef void (^FailureBlock)(NSError *error);

typedef void (^SuccessBlock1)(NSDictionary *result);

@interface DataService : NSObject

+ (void)getHomeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getHotPicRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getArticleRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getGoodThingRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getShopTopRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getShopCellRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getHotPeopleRequestSuccess:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;


//新增:
+ (void)getSearchRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;
+ (void)getThemeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;
+(void)getDefaultThemeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+(void)getDetailsRequestWithNextStart:(NSString *)start Success:(SuccessBlock1)sBlock failure:(FailureBlock)fBlock;
+(void)getAdvertiseRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;


//主题的
+ (void)getThemeCellRequestWithNextStart:(NSString *)start andStar:(NSString*)star Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;
+ (void)getCategaryRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;


+ (void)getSubscribRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

+ (void)getSubscribTitleRequestWithNextStart:(NSString *)start Success:(SuccessBlock1)sBlock failure:(FailureBlock)fBlock;



@end
