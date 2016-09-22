//
//  PictureBgView.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PictureBgView.h"
#import "BlockView.h"
#import "Common.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "ThemeViewController.h"

@interface PictureBgView ()

@property(nonatomic,copy) NSArray *data;
@property(nonatomic,copy) NSMutableArray *pictureTypeOneName;
@property(nonatomic,copy) NSMutableArray *pictureTypeTwoName;
@property(nonatomic,copy) NSMutableArray *pictureTypeThreeName;
@property(nonatomic,copy)NSMutableArray *pictureTypeOneUrl;
@property(nonatomic,copy)NSMutableArray *pictureTypeTwoUrl;
@property(nonatomic,copy)NSMutableArray *pictureTypeThreeUrl;

@property(nonatomic,copy)NSMutableArray *pictureTypeOneTarget;
@property(nonatomic,copy)NSMutableArray *pictureTypeTwoTarget;
@property(nonatomic,copy)NSMutableArray *pictureTypeThreeTarget;


@end


@implementation PictureBgView
    



- (NSMutableArray *)pictureTypeTwoUrl {
    if (_pictureTypeTwoUrl ==nil) {
        _pictureTypeTwoUrl =[NSMutableArray array];
        NSDictionary *HotPicturetheme =self.data[3];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *icon_url = dic[@"icon_url"];
            [_pictureTypeTwoUrl addObject:icon_url];
            
            
        }
        
  
        
        
    }
    return _pictureTypeTwoUrl;
}

- (NSMutableArray *)pictureTypeThreeUrl {
    if (_pictureTypeThreeUrl ==nil) {
        _pictureTypeThreeUrl =[NSMutableArray array];
        NSDictionary *HotPicturetheme =self.data[4];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *icon_url = dic[@"icon_url"];
            [_pictureTypeThreeUrl addObject:icon_url];
            
            
        }
        
        
    }
    return _pictureTypeThreeUrl;
}

- (NSMutableArray *)pictureTypeOneUrl {
    if (_pictureTypeOneUrl ==nil) {
        _pictureTypeOneUrl =[NSMutableArray array];
        
        NSDictionary *HotPicturetheme =self.data[2];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *icon_url = dic[@"icon_url"];
            [_pictureTypeOneUrl addObject:icon_url];
        }
    }
    return _pictureTypeOneUrl;
}


- (NSMutableArray *)pictureTypeOneName {
    if (_pictureTypeOneName ==nil) {
        _pictureTypeOneName = [NSMutableArray array];
        
        NSDictionary *HotPicturetheme =self.data[2];
        NSArray *group_items = HotPicturetheme[@"group_items"];

        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"name"];
            [_pictureTypeOneName addObject:name];
            
            
        }
        
 
    }

    return _pictureTypeOneName;
    
}

- (NSMutableArray *)pictureTypeTwoName {
    
    if (_pictureTypeTwoName ==nil) {
        _pictureTypeTwoName = [NSMutableArray array];
        NSDictionary *HotPicturetheme =self.data[3];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"name"];
            [_pictureTypeTwoName addObject:name];
            
            
            
            
        }

    }
 
    return _pictureTypeTwoName;
    
}

- (NSMutableArray *)pictureTypeThreeName {
    
    if (_pictureTypeThreeName == nil) {
        _pictureTypeThreeName = [NSMutableArray array];
        NSDictionary *HotPicturetheme =self.data[4];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"name"];
            [_pictureTypeThreeName addObject:name];
            
            
        }

    }
    return _pictureTypeThreeName;
    
}

- (NSMutableArray *)pictureTypeOneTarget {
    if (_pictureTypeOneTarget ==nil) {
        _pictureTypeOneTarget =[NSMutableArray array];
        
        NSDictionary *HotPicturetheme =self.data[2];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"target"];
            [_pictureTypeOneTarget addObject:name];
            
            
        }

    }
    return _pictureTypeOneTarget;
    
}


- (NSMutableArray *)pictureTypeTwoTarget {
    if (_pictureTypeTwoTarget ==nil) {
        _pictureTypeTwoTarget =[NSMutableArray array];
        
        NSDictionary *HotPicturetheme =self.data[3];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"target"];
            [_pictureTypeTwoTarget addObject:name];
            
            
        }
        
    }
    return _pictureTypeTwoTarget;
    
}

- (NSMutableArray *)pictureTypeThreeTarget {
    if (_pictureTypeThreeTarget ==nil) {
        _pictureTypeThreeTarget =[NSMutableArray array];
        
        NSDictionary *HotPicturetheme =self.data[4];
        NSArray *group_items = HotPicturetheme[@"group_items"];
        
        for (NSDictionary *dic in group_items) {
            
            NSString *name = dic[@"target"];
            [_pictureTypeThreeTarget addObject:name];
            
            
        }
        
    }
    return _pictureTypeThreeTarget;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self _requestData];
       
        
        
    }
    return self;
    
}

- (void)_requestData{
    [DataService getDefaultThemeRequestWithNextStart:nil Success:^(NSArray *result, NSString *start) {
    
        self.data = result;
          [self _loadSubView];
        
    } failure:^(NSError *error) {
        NSLog(@"请求默认主题成功");
    }];
    
}


- (void)_loadSubView {
    

    CGFloat blockViewWidth = kScreenWidth/2;
    CGFloat blockViewHeight = 60;
    
    
    //1.
    for (NSInteger i =0; i<self.pictureTypeOneName.count; i++) {
       
     BlockView *view =
     [[BlockView alloc] initWithFrame:CGRectMake((i%2)*blockViewWidth, (i/2)*blockViewHeight, 0, 0)
    image:self.pictureTypeOneUrl[i]
      
    tetx:self.pictureTypeOneName[i]];
    view.theme =self.pictureTypeOneName[i];
       
    [self addSubview:view];
        
        
        view.userInteractionEnabled=YES;
        view.target = self.pictureTypeOneTarget[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheme:) ];
        [view addGestureRecognizer:tap];
        
        
    }
    
    //2.
    UIImageView *imgView_1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, blockViewHeight*3, 60, blockViewHeight)];
    imgView_1.image = [UIImage imageNamed:@"share_icon_more@2x.png"];
    [self addSubview:imgView_1];
    
    //3.
    
    for (NSInteger i = 0; i<self.pictureTypeTwoName.count; i++) {
        BlockView *view =
        [[BlockView alloc] initWithFrame:CGRectMake((i%2)*blockViewWidth, 4*60+(i/2)*blockViewHeight, 0, 0)
                                   image:self.pictureTypeTwoUrl[i]
         
                                    tetx:self.pictureTypeTwoName[i]];
        
        view.theme =self.pictureTypeTwoName[i];
        [self addSubview:view];
        
        
        view.userInteractionEnabled=YES;
        view.target = self.pictureTypeTwoTarget[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheme:) ];
        [view addGestureRecognizer:tap];


    }
    
    //4.
    UIImageView *imgView_2 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, blockViewHeight*6, 60, blockViewHeight)];
    imgView_2.image = [UIImage imageNamed:@"share_icon_more@2x.png"];
    [self addSubview:imgView_2];
    
    
    
    //5.
    for (NSInteger i =0; i<self.pictureTypeThreeName.count; i++) {
        
        BlockView *view =
        [[BlockView alloc] initWithFrame:CGRectMake((i%2)*blockViewWidth, 7*60+(i/2)*blockViewHeight, 0, 0)
                                   image:self.pictureTypeThreeUrl[i]
         
                                    tetx:self.pictureTypeThreeName[i]];
        view.theme =self.pictureTypeThreeName[i];
        [self addSubview:view];
        view.userInteractionEnabled=YES;
        view.target = self.pictureTypeThreeTarget[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheme:) ];
        [view addGestureRecognizer:tap];

        
        
    }

    
}


- (void)clickTheme:(UITapGestureRecognizer *)tap{
    BlockView *bView =(BlockView*) tap.view;
   
    
    NSString *target = bView.target;
    NSRange range = [target rangeOfString:@"id="];
    NSString *cate_id = [target substringFromIndex:range.location+3];

    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    
    ThemeViewController *theme =[sb instantiateViewControllerWithIdentifier:@"themeConreoller"];
    
    UIViewController *controller = [self getViewController];
    theme.condition=cate_id;
    theme.theme = bView.theme;
    controller.hidesBottomBarWhenPushed=YES;
    [controller.navigationController pushViewController:theme animated:YES ];
    controller.hidesBottomBarWhenPushed=NO;
    
    
    
}


- (UIViewController *)getViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
