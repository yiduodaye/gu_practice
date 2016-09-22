//
//  DataService.m
//  ImagineWeibo
//
//  Created by Imagine on 16/8/13.
//  Copyright © 2016年 Imagine. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"

#define BaseUrl @"http://103.21.119.166/napi/"
#define MidUrl @"locale=zh-Hant_CN&limit=0&screen_height=568&screen_width=320&ad_id=IGA009&start="
#define EndUrl @"&platform_version=8.0.2&query_type=normal&device_platform=iPhone5%2C2&platform_name=iPhone%20OS&app_code=gandalf&__domain=www.duitang.com&app_version=6.2.2%20rv%3A164216&device_name=iPhone%205"

@implementation DataService


+ (void)getHomeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@ad/banner/list/?%@%@%@", BaseUrl, MidUrl, start, EndUrl];
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}


+ (void)getHotPicRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@index/hot/?%@%@%@", BaseUrl, MidUrl, start, EndUrl];
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}


+ (void)getArticleRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@topic/article/list/?%@%@%@", BaseUrl, MidUrl, start, EndUrl];
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}


+ (void)getGoodThingRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url1 = @"http://103.21.119.166/napi/blog/list/by_category/?cate_key=5017d172705cbe10c0000003&limit=0&locale=zh-Hant_CN&screen_height=568&screen_width=320&include_fields=sender%2Cfavroite_count%2Calbum%2Cicon_url%2Creply_count%2Clike_count&start=";
    NSString *url2 = @"&platform_version=8.0.2&app_code=gandalf&platform_name=iPhone%20OS&device_platform=iPhone5%2C2&__domain=www.duitang.com&app_version=6.2.2%20rv%3A164216&device_name=iPhone%205";
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", url1, start, url2];
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}

+ (void)getShopTopRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url = @"http://103.21.119.166/napi/ad/banner/list/?locale=zh-Hant_CN&limit=30&screen_height=568&timestamp=1471657197000&screen_width=320&ad_id=COM001&platform_version=8.0.2&app_code=gandalf&device_platform=iPhone5%2C2&platform_name=iPhone%20OS&__domain=www.duitang.com&app_version=6.2.2%20rv%3A164216&device_name=iPhone%205";
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}

+ (void)getShopCellRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    NSString *url = @"http://103.21.119.167/napi/ad/banner/list/?locale=zh-Hant_CN&limit=30&screen_height=568&timestamp=1471656083000&screen_width=320&ad_id=COM003&platform_version=8.0.2&app_code=gandalf&device_platform=iPhone5%2C2&platform_name=iPhone%20OS&__domain=www.duitang.com&app_version=6.2.2%20rv%3A164216&device_name=iPhone%205";
    
    [DataService getRequest:url Success:sBlock failure:fBlock];
}


+ (void)getRequest:(NSString *)url Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSString *start = dataDic[@"next_start"];

        NSArray *objectArray = dataDic[@"object_list"];
        
        sBlock(objectArray, start);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];
    
}

+ (void)getHotPeopleRequestSuccess:(SuccessBlock)sBlock failure:(FailureBlock)fBlock{
    
    
    
    NSString *url =@"http://103.21.119.167/napi/people/group/daren/?filter_id=544f13a50cf22d119065015c&locale=zh-Hant_CN&limit=0&screen_height=568&screen_width=320&start=0&platform_version=8.0.2&app_code=gandalf&platform_name=iPhone%20OS&device_platform=iPhone5%2C2&__domain=www.duitang.com&app_version=6.2.2%20rv%3A164216";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSArray *objectArray = dataDic[@"object_list"];
        
        sBlock(objectArray, nil);
   
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];

    
}

//新增:



+ (void)getSearchRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    
    //拼接
//    NSString *url = @"http://221.228.82.178/napi/blog/list/by_search/?platform_name=iPhone%20OS&start=0&__domain=www.duitang.com&include_fields=sender%2Cfavroite_count%2Calbum%2Cicon_url%2Creply_count%2Clike_count&app_version=6.3.1%20rv%3A166591&buyable=0&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&kw=%E7%A7%8B%E5%A4%A9&screen_width=375";
   
    
    start = [start stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSString *url_former =@"http://221.228.82.178/napi/blog/list/by_search/?platform_name=iPhone%20OS&start=0&__domain=www.duitang.com&include_fields=sender%2Cfavroite_count%2Calbum%2Cicon_url%2Creply_count%2Clike_count&app_version=6.3.1%20rv%3A166591&buyable=0&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&kw=";
    NSString *url_laster = @"&screen_width=375";
    NSString *url=[url_former stringByAppendingString:start];
    url = [url stringByAppendingString:url_laster];
    
    //
     [DataService getRequest:url Success:sBlock failure:fBlock];
    
   
}


+ (void)getThemeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    
    //拼接http://221.228.82.178/napi/theme/list/by_keyword/?locale=zh_CN&device_name=Unknown%20iPhone&app_version=6.3.1%20rv%3A166591&app_code=gandalf&platform_version=9.3.4&platform_name=iPhone%20OS&keyword=%E7%81%B0%E5%A7%91%E5%A8%98%E4%B8%8E%E5%9B%9B%E9%AA%91%E5%A3%AB&device_platform=iPhone8%2C1&screen_height=667&screen_width=375&__domain=www.duitang.com
    
       start = [start stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url_former =@"http://221.228.82.178/napi/theme/list/by_keyword/?locale=zh_CN&device_name=Unknown%20iPhone&app_version=6.3.1%20rv%3A166591&app_code=gandalf&platform_version=9.3.4&platform_name=iPhone%20OS&keyword=";
    NSString *url_laster = @"&device_platform=iPhone8%2C1&screen_height=667&screen_width=375&__domain=www.duitang.com";
    NSString *url=[url_former stringByAppendingString:start];
    url = [url stringByAppendingString:url_laster];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSString *start = dataDic[@"next_start"];
        
        NSArray *objectArray = dataDic[@"items"];
        
        sBlock(objectArray, start);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];
}


+ (void)getDefaultThemeRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock {
    
    

    
 
   NSString *url = @"http://221.228.82.181/napi/index/groups/?locale=zh_CN&device_name=Unknown%20iPhone&app_version=6.3.1%20rv%3A166591&platform_version=9.3.4&app_code=gandalf&platform_name=iPhone%20OS&device_platform=iPhone8%2C1&screen_height=667&screen_width=375&__domain=www.duitang.com";
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSArray *objectArray=resultDic[@"data"];
        sBlock(objectArray, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];
}



+ (void)getDetailsRequestWithNextStart:(NSString *)start Success:(SuccessBlock1)sBlock failure:(FailureBlock)fBlock{
    
    NSString *url_former =@"http://221.228.82.178/napi/blog/detail/?platform_name=iPhone%20OS&__domain=www.duitang.com&include_fields=tags%2Crelated_albums%2Crelated_albums.covers%2Croot_album%2Cshare_links_3%2Cextra_html%2Ctop_comments%2Ctop_like_users&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&top_like_users_count=8&locale=zh_CN&app_code=gandalf&platform_version=9.3.4&screen_height=667&top_forward_users_count=8&device_name=Unknown%20iPhone&blog_id=";
    NSString *url_laster = @"&screen_width=375&top_comments_count=12";
    NSString *numberID=[NSString stringWithFormat:@"%@",start];
    NSString *url=[url_former stringByAppendingString:numberID];
    url = [url stringByAppendingString:url_laster];
    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        

        
        sBlock(dataDic);

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];

    
    
}


+(void)getAdvertiseRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock{
    
    
    NSString *url =@"http://221.228.82.181/napi/ad/banner/list/?platform_name=iPhone%20OS&__domain=www.duitang.com&timestamp=1473211811000&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&locale=zh_CN&app_code=gandalf&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=30&ad_id=COM003&screen_width=375";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSArray *objectArray = dataDic[@"object_list"];
        
        sBlock(objectArray, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];

    
}

//主题的
+ (void)getThemeCellRequestWithNextStart:(NSString *)start  andStar:(NSString*)star Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock{
 
    //http://221.228.82.181/napi/blog/list/by_category/?platform_name=iPhone%20OS&start=0&__domain=www.duitang.com&include_fields=sender%2Cfavroite_count%2Calbum%2Cicon_url%2Creply_count%2Clike_count&filter_params=%7B%0A%0A%7D&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&cate_key=5451f506586df593cccf3f3b&screen_width=375
    NSString *url_a=@"http://221.228.82.181/napi/blog/list/by_category/?platform_name=iPhone%20OS&start=";
    NSString *sts = [NSString stringWithFormat:@"%@",star];

    url_a = [url_a stringByAppendingString:sts];
    NSString *url_b = @"&__domain=www.duitang.com&include_fields=sender%2Cfavroite_count%2Calbum%2Cicon_url%2Creply_count%2Clike_count&filter_params=%7B%0A%0A%7D&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&cate_key=";
    

    NSString *url_former =[url_a stringByAppendingString:url_b];
    NSString *url_laster = @"&screen_width=375";
    NSString *cate = [NSString stringWithFormat:@"%@",start];
    NSString *url=[url_former stringByAppendingString:cate];
    url = [url stringByAppendingString:url_laster];
    

    //
    [DataService getRequest:url Success:sBlock failure:fBlock];
    

    
}

+ (void)getCategaryRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock{
    
   
    
    NSString *url_former =@"http://221.228.82.181/napi/category/detail/?locale=zh_CN&app_version=6.3.1%20rv%3A166591&device_name=Unknown%20iPhone&category_id=";
    NSString *url_laster = @"&app_code=gandalf&platform_name=iPhone%20OS&device_platform=iPhone8%2C1&platform_version=9.3.4&screen_height=667&screen_width=375&__domain=www.duitang.com";
    NSString *cate = [NSString stringWithFormat:@"%@",start];
    NSString *url=[url_former stringByAppendingString:cate];
    url = [url stringByAppendingString:url_laster];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSArray *objectArray = dataDic[@"sub_cates"];
        
        sBlock(objectArray, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];
    

    

}

+ (void)getSubscribRequestWithNextStart:(NSString *)start Success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock{
    
    

   // 554c8abaa310def67913c5c0&theme_alias=%E4%BB%8A%E6%97%A5TOP%E6%A6%9C&app_layout=BLOG_THEME
    NSRange range1 = [start rangeOfString:@"theme_alias="];
    NSString *start_1 =  [start substringFromIndex:range1.location+range1.length];
    
    NSRange range2 = [start_1 rangeOfString:@"&app_layout="];
    NSString *start_2 = [start_1 substringToIndex:range2.location];
    NSRange limit = [start rangeOfString:@"TOP"];

    NSString *url_former;

    if (limit.length !=0) {
         url_former =@"http://103.21.119.167/napi/blog/list/by_filter_id/?platform_name=iPhone%20OS&start=0&__domain=www.duitang.com&include_fields=album%2Csender%2Cicon_url%2Creply_count%2Clike_count&filter_params=%7B%0A%0A%7D&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&filter_id=";
    }
    else{
     url_former =@"http://103.21.119.167/napi/blog/list/by_filter_id/?platform_name=iPhone%20OS&start=0&__domain=www.duitang.com&include_fields=album%2Csender%2Cicon_url%2Creply_count%2Clike_count&filter_params=%7B%0A%0A%7D&app_version=6.3.1%20rv%3A166591&device_platform=iPhone8%2C1&app_code=gandalf&locale=zh_CN&platform_version=9.3.4&screen_height=667&device_name=Unknown%20iPhone&limit=0&filter_id=%E5%9B%BE%E7%89%87_";
    }
    NSString *url_laster = @"&screen_width=375";
    NSString *url=[url_former stringByAppendingString:start_2];
    url = [url stringByAppendingString:url_laster];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];
        
        NSString *start = dataDic[@"next_start"];
        
        NSArray *objectArray = dataDic[@"object_list"];
        
        sBlock(objectArray, start);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];

    
    
    
}


+ (void)getSubscribTitleRequestWithNextStart:(NSString *)start Success:(SuccessBlock1)sBlock failure:(FailureBlock)fBlock{
    

    NSRange range =  [start rangeOfString:@"&theme_alias"];
    NSString *start_1 = [start substringToIndex:range.location];

    NSString *url_former =@"http://103.21.119.167/napi/theme/detail/?locale=zh_CN&device_name=Unknown%20iPhone&app_version=6.3.1%20rv%3A166591&platform_version=9.3.4&app_code=gandalf&platform_name=iPhone%20OS&device_platform=iPhone8%2C1&screen_height=667&screen_width=375&theme_id=";
    NSString *url_laster = @"&__domain=www.duitang.com";
    NSString *url=[url_former stringByAppendingString:start_1];
    url = [url stringByAppendingString:url_laster];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        NSDictionary *dataDic = resultDic[@"data"];

        
        sBlock(dataDic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fBlock(error);
    }];
    

    
    
}

@end
