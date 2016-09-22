//
//  ShopCellModel.h
//  project_3
//
//  Created by Imagine on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCellModel : UITableViewCell

/*
 "object_list": [
 {
 "target": "http://www.duitang.com/guide2/mkt/2016818vip_juhe/?__urlopentype=pageweb&app_version=6.2.2&app_code=gandalf",
 "tag": "NEW",
 "stitle": "6个主题专场 & 百款会员特价",
 "style": "",
 "nickname": "",
 "content_type": "",
 "image_url": "http://img4q.duitang.com/uploads/item/201608/18/20160818191850_HCM4m.jpeg",
 "enabled_at": 1471572001,
 "enabled_at_str": "2016-08-19 10:00:01",
 "disabled_at": 1471917600,
 "disabled_at_str": "2016-08-23 10:00:00",
 "description": "会员招募 · 特别策划",
 "tag_title": "",
 "dynamic_info": "",
 "dynamic_info2": "0",
 "icon_url": "",
 "ext_info": "",
 "content_category": ""
 },
 {
 "target": "http://www.duitang.com/guide2/buy_group_purchase/2016081901/?__urlopentype=pageweb&app_version=6.2.2&app_code=gandalf",
 "tag": "NEW",
 "stitle": "第九期·生活家",
 "style": "",
 "nickname": "",
 "content_type": "",
 "image_url": "http://img4q.duitang.com/uploads/people/201608/18/20160818122249_nwV4u.jpeg",
 "enabled_at": 1471572000,
 "enabled_at_str": "2016-08-19 10:00:00",
 "disabled_at": 1472090400,
 "disabled_at_str": "2016-08-25 10:00:00",
 "description": "在家也能做的夏日冰爽美食",
 "tag_title": "",
 "dynamic_info": "",
 "dynamic_info2": "0",
 "icon_url": "",
 "ext_info": "",
 "content_category": ""
 },
 
 */

@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *sTitle;
@property (nonatomic, copy) NSString *sDescription;
@property (nonatomic, copy) NSString *image_url;

@end
