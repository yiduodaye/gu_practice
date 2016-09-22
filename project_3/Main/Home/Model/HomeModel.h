//
//  HomeModel.h
//  project_3
//
//  Created by Imagine on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

/*
 target": "http://dwz.cn/3WqlJ7?from=app&__urlopentype=pageweb&app_version=6.2.2&app_code=gandalf",
 "tag": "NEW",
 "stitle": "欧莱雅“奇焕润发精油”蔷薇臻耀系列。",
 "style": "large",
 "content_type": "ad",
 "image_url": "http://img3.duitang.com/uploads/item/201608/12/20160812172441_yk8NP.jpeg",
 "enabled_at": 1471395606,
 "enabled_at_str": "2016-08-17 09:00:06",
 "disabled_at": 1471449599,
 "disabled_at_str": "2016-08-17 23:59:59",
 "description": "蔷薇馨香 滋养闪耀",
 "tag_title": "",
 "dynamic_info": "推广",
 "icon_url": "http://img4q.duitang.com/uploads/people/201603/01/20160301132538_aCAuH.png",
 "ext_info": "",
 "content_category": "推广"
 },
 {
 "target": "http://www.duitang.com/guide2/event/toplistReplenishment/?__urlopentype=pageweb&frombanner=1&app_version=6.2.2&app_code=gandalf",
 "tag": "NEW",
 "stitle": "口碑榜好货，每周三更新。",
 "style": "small",
 "nickname": "",
 "content_type": "store",
 "image_url": "http://img4q.duitang.com/uploads/people/201608/16/20160816154309_k8S4C.jpeg",
 "enabled_at": 1471395606,
 "enabled_at_str": "2016-08-17 09:00:06",
 "disabled_at": 1502931606,
 "disabled_at_str": "2017-08-17 09:00:06",
 "description": "Vol.46 | 开挂补水好物",
 "tag_title": "",
 "dynamic_info": "堆糖商店",
 "icon_url": "http://img4q.duitang.com/uploads/people/201603/09/20160309111339_BXjsT.png",
 "ext_info": "",
 "content_category": "堆糖商店"
 },

 */

@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *sDescription;
@property (nonatomic, copy) NSString *sTitle;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *dynamic_info;

@end
