//
//  DiscoverTableViewController.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "Common.h"
#import "DiscoverHeaderView.h"
#import "RecommondTableViewCell.h"
#import "DiscoverFooterView.h"
#import "PictureBgView.h"
#import "RecommondPictureViewController.h"
#import "SearchViewController.h"
#import "Advertise.h"
#import "ArticleViewController.h"

@interface DiscoverTableViewController () {
    
    NSArray *cellImageName ;
    NSArray *cellLabelText;
    UIImageView *navigationBgImageView;
    UIButton *button;
}

@end

@implementation DiscoverTableViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self _loadNavigationSubView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [button removeFromSuperview];
    [navigationBgImageView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self _loadData];
}

- (void)_loadData{
    
    cellImageName = @[@"icon_explore_picture@2x",@"icon_explore_article@2x",@"icon_explore_goods@2x"];
    cellLabelText = @[@"热门图片",@"文章",@"好物"];
}

- (void)_loadNavigationSubView{
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.frame = CGRectMake(0, 0, 60  , 60);
    [button setImage:[UIImage imageNamed:@"Qr_icon@2x.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(kScreenWidth-10-30, (kNavigationBarHeigth-20-30)/2, 30  , 30);
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = rightButton;
     [self.navigationController.navigationBar addSubview:button];

    navigationBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-10-button.width-10*2 ,kNavigationBarHeigth-5*2-kStatusBar )];
    navigationBgImageView.userInteractionEnabled =YES;
    navigationBgImageView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:navigationBgImageView];
    
    navigationBgImageView.layer.borderWidth = 1;
      navigationBgImageView.layer.borderColor = [UIColor grayColor].CGColor;
    navigationBgImageView.layer.cornerRadius =5;
    
    //放大镜视图
    UIImageView *magnifyView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, navigationBgImageView.height-10, navigationBgImageView.height-10)];
    
    magnifyView.image = [UIImage imageNamed:@"tab_icon_explore@2x.png"];
    [navigationBgImageView addSubview:magnifyView];
    
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(5+magnifyView.width, 5, navigationBgImageView.width-magnifyView.width-20, magnifyView.height)];
    [navigationBgImageView addSubview:textfield];
    textfield.placeholder=@"搜索感兴趣的内容...";
    textfield.textColor = [UIColor grayColor];
    textfield.delegate=self;
    [textfield setEnabled:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

#pragma mark 返回每组的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) {
        return 0;
    }
    else if(section == 1) {
        return 3;
    }
    else
        return 0;
}

#pragma mark 设置组头视图高度

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section ==0) {
        return 80;
    }
    else
        return 30;
}

#pragma mark 设置组尾视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 200;
    }
    else if (section ==2){
        return 10*60;
    }
    else
        return 0;
}

#pragma mark 设置组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeigth, kScreenWidth, 80)];
        
        UIImageView *followImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 22.5, 35, 35)];
        followImageView.image =[UIImage imageNamed:@"icon_explore_follow@2x.png"];
        [firstView addSubview:followImageView];
        
        UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+followImageView.width+10, (firstView.height-30)/2, 90, 30)];
        followLabel.text = @"关注动态";
        followLabel.textColor = [UIColor grayColor];
        [firstView addSubview:followLabel];
        
        UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-2)/2, 10, 2, 60)];
        bannerView.image = [UIImage imageNamed:@"large_banner_cover@2x.png"];
        [firstView addSubview:bannerView];
        
        
        UIImageView *myClubImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bannerView.right+22.5, 22.5, 35, 35)];
        myClubImageView.image = [UIImage imageNamed:@"icon_explore_club@2x.png"];
        [firstView addSubview:myClubImageView];
        
        UILabel *myClubLabel = [[UILabel alloc] initWithFrame:CGRectMake(myClubImageView.right+10,  (firstView.height-30)/2, 90, 30)];
        myClubLabel.textColor= [UIColor grayColor];
        myClubLabel.text = @"我的Club";
        [firstView addSubview:myClubLabel];
        
        return firstView;
    }
  //第二组头视图
    else if (section ==1) {
        return [[DiscoverHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) text:@"热门图片"];
    }
    
  //第三组头视图
    else
        return [[DiscoverHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) text:@"图片分类"];
}

#pragma mark 设置组尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section ==1) {
        
        return [[DiscoverFooterView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    else if (section ==2){
     
       PictureBgView *thirdView =[[PictureBgView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
        return thirdView;
    }
    else
        return nil;
}

#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section ==0) {
        return nil;
    }
    else if (indexPath.section ==1)
    {
        RecommondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell" forIndexPath:indexPath];
        
        cell.ImgView.image = [UIImage imageNamed:cellImageName[indexPath.row]];
        cell.Label.text = cellLabelText[indexPath.row];
        cell.enterImage.image =[UIImage imageNamed:@"stickers_icon_forward@2x.png"];
    
        return cell;
    }
    else{
//       UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"pictureCell" ];
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picture"];
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
//        view.backgroundColor = [UIColor redColor];
//        [cell setHeight:500];
//        [cell.contentView addSubview:view];
        return nil;
    }
}

#pragma mark 点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
        
        RecommondPictureViewController *recommond =[sb instantiateViewControllerWithIdentifier:@"waterfallController"];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:recommond animated:YES ];
        self.hidesBottomBarWhenPushed=NO;
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
        
        ArticleViewController *recommond =[sb instantiateViewControllerWithIdentifier:@"articleController"];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recommond animated:YES ];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark textField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    SearchViewController *search = [[SearchViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


@end
