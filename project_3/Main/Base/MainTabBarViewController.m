//
//  MainTabBarViewController.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "Common.h"
#import "BaseNavViewController.h"


@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadSubController];
    [self _removeTabBarButton];

}

#pragma mark 添加子控制器
- (void)_loadSubController{
    NSArray *controllerName = @[@"Home",@"Discover",@"Shop",@"Personage"];
    //存放控制器，最后交给navigationController
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    //从storyboard中加载子控制器
    for (NSString *name in controllerName) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
        
        BaseNavViewController *nv = [sb instantiateInitialViewController];
        [controllerArray addObject:nv];
        
    }
    
    
    self.viewControllers =controllerArray;
    
}

#pragma mark 自定义TabBar按钮

- (void)_removeTabBarButton{
    
    
    //移除自带的按钮
    for (UIView *subView in self.tabBar.subviews) {
        
        //只移除按钮，不要移除其他子视图
        Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
        
        if ([subView isKindOfClass:tabBarButtonClass]) {
            [subView removeFromSuperview];
        }
        
        
    }
    
    //自定义按钮
    CGFloat buttonWidth = kScreenWidth / 4;
    NSArray *buttonName = @[@"tab_icon_home@2x.png",@"tab_icon_explore@2x.png",@"tab_icon_store@2x.png",@"tab_icon_me@2x.png"];
    NSArray *buttonName_higthlight =@[@"tab_icon_home_highlight@2x.png",@"tab_icon_explore_highlight@2x.png",@"tab_icon_store_highlight@2x.png",@"tab_icon_me_highlight@2x.png"];
    
    for (NSInteger i =0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, kTabBarHeight);
        [button setImage:[UIImage imageNamed:buttonName[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonName_higthlight[i]] forState: UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:buttonName_higthlight[i]] forState: UIControlStateSelected];
        [self.tabBar addSubview:button];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+100;
        if (i ==0) {
            button.selected =YES;
        }
        
        
    }
    
    
    
}


- (void)buttonAction:(UIButton *)button {
    
    self.selectedIndex = button.tag-100;
    
    
    if (button.selected) {
        return;
    }
    
    else {
        button.selected =!button.selected;
    }
    
    
    for (NSUInteger i = 0; i <4; i++) {
        
        if (i != self.selectedIndex) {
            
            UIButton *btn = [self.tabBar viewWithTag:i+100];
            btn.selected = NO;
            
        }
        
    }
    
    
    
}


@end
