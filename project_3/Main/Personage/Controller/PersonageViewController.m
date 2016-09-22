//
//  PersonageViewController.m
//  project_3
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonageViewController.h"
#import "Common.h"
#import "UnderLineButton.h"
#import "PersonageTableView.h"
#import "PersonageHeaderView.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "PersonageFooterView.h"
#import "SettingsTableViewController.h"
#import "LoginViewController.h"
#import "AddFriendsTableViewController.h"
#import "MyselfViewController.h"


@interface PersonageViewController ()
@property(nonatomic,copy)NSArray *labelText;
@property(nonatomic,copy)NSArray *imageArray;
//每一组单元格的个数
@property(nonatomic,copy)NSArray *rowsArray;

@end

@implementation PersonageViewController

//将要显示的时候隐藏navigationBar


- (NSArray *)rowsArray {
    if (_rowsArray == nil) {
        _rowsArray =@[@1,@1,@2,@4,@3,@1];
    }
    return _rowsArray;
}
- (NSArray *)labelText {
    if (_labelText ==nil) {
        //_labelText.count =12（实际只用到了后11个）。
        _labelText = @[@"空",@"我的订单",@"我的礼券",@"我的福袋",@"我的专辑",@"我的文章",@"我的收藏",@"我的订阅",@"评论",@"收藏/赞",@"聊天",@"添加好友"];
    }
    return _labelText;
    
}

- (NSArray *)imageArray {
    if (_imageArray == nil    ) {
        _imageArray =@[@"icon_Club_users@3x.png",@"me_icon_order@2x.png",@"me_icon_coupon@2x.png",@"me_icon_luckybag@2x.png",@"me_icon_album@2x.png",@"icon_explore_article@2x.png",@"me_icon_collect@2x.png",@"me_icon_subscribe@2x.png",@"me_icon_comments@2x.png",@"me_icon_notification@2x.png",@"me_icon_message@2x.png",@"profile_icon_follow@2x.png"];
    }
    return _imageArray;
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView =[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _bgImageView;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tableView.hidden =NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"acount" ]!= nil && [user objectForKey:@"pwd"] != nil) {
        self.bgImageView.hidden =YES;
    }
    else {
        self.bgImageView.hidden =NO;
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent=YES;
    self.tableView.delegate =self;
   
    self.tableView.dataSource =self;
    
    [self _loadNavigationBarSubView];
    [self _loadBgImageView];
    
    //self.bgImageView .hidden =YES;
}

//将要离开的时候显示navigationBar
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)_setBackBarButton{
    
 
    UIBarButtonItem *back =[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [self.navigationItem
     setBackBarButtonItem:back];
    
}

- (void)_loadBgImageView{
    
    self.bgImageView.image = [UIImage imageNamed:@"walkthroughs_bg.png"];
    self.bgImageView.userInteractionEnabled =YES;
    [self.view addSubview:self.bgImageView];
    
    //设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(kScreenWidth -45, kStatusBar, 35, 35);
    [settingButton setImage:[UIImage imageNamed:@"icon_set_light@2x.png"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"icon_set_dark@2x.png"] forState:UIControlStateHighlighted];
    [settingButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgImageView addSubview:settingButton];
    
    //logo
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, settingButton.bottom +30, 100, 50)];
    logoView.image = [UIImage imageNamed:@"walkthroughs_logo@2x.png"];
    [self.bgImageView addSubview:logoView];
    
    //注册提示Label
    
    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(45, logoView.bottom+30, kScreenWidth-45*2, 30)];
    textLabel1.textColor = [UIColor whiteColor];
    textLabel1.textAlignment = NSTextAlignmentCenter;
    textLabel1.text =@"轻松注册，即可永久保存你的所爱";
    //设置字体
    NSArray *fontArray = [UIFont familyNames];
    textLabel1.font = [UIFont fontWithName:fontArray[40] size:15];
    [self.bgImageView addSubview:textLabel1];
    
    //换了手机也找得到哦
    
    UILabel *textlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(45, textLabel1.bottom, kScreenWidth-45*2, 30)];
    textlabel2.textColor = [UIColor whiteColor];
    textlabel2.textAlignment = NSTextAlignmentCenter;
    textlabel2.text =@"换了手机也找得到哦";
    textlabel2.font = [UIFont fontWithName:fontArray[40] size:15];
    //不管是弹出视图，还是主视图都存在这个按钮
    [self.bgImageView addSubview:textlabel2];
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame= CGRectMake((kScreenWidth -100)/2, textlabel2.bottom+30, 100, 35);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bgImageView addSubview:registerButton];
    registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    registerButton.layer.borderWidth = 1;
    registerButton.layer.cornerRadius =5;
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    //登录label
    
    UILabel *notifyLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-120)/2, registerButton.bottom+10, 60, 20)];
    notifyLabel.text =@"已有账号?";
    notifyLabel.textColor = [UIColor whiteColor];
    notifyLabel.textAlignment = NSTextAlignmentCenter;
    notifyLabel.font = [UIFont fontWithName:fontArray[40] size:13];
    [self.bgImageView addSubview:notifyLabel];
    
    
    UnderLineButton *loginButton = [[UnderLineButton alloc] initWithFrame:CGRectMake(notifyLabel.right, notifyLabel.top, notifyLabel.width, notifyLabel.height)];
    
    [loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setFont:[UIFont systemFontOfSize:13]];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:loginButton];
    
    //可以用NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"下划线" attributes:attribtDic];
    //这样也可以设置下划线.
    
}

- (void)_loadNavigationBarSubView{
    
    self.navigationItem.title =@"我";
    //self.navigationItem setTitleView:<#(UIView * _Nullable)#>
    //好像无法直接改变标题的字体
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame= CGRectMake(0, 0, 30, 30);
    [settingBtn setImage:[UIImage imageNamed:@"icon_set_dark@2x.png"] forState:UIControlStateNormal];

    [settingBtn addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem =rightButton;
    
}
#pragma mark 按钮方法
- (void)settings {
   
    self.tableView.hidden =YES;
   // self.tabBarController.tabBar.hidden =YES;
     [self _setBackBarButton];
    
    SettingsTableViewController *settings =[[SettingsTableViewController alloc] init];
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:settings animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

- (void)registerAction{
    NSLog(@"注册界面");
    
}

- (void)login{
    NSLog(@"登录界面");
    
    LoginViewController *login =[[LoginViewController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}


#pragma mark tableview代理方法
//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if  (indexPath.section ==0){
        return 80;
    }
    else{
        return 40;
    }
}
//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        
        //返回0也是存在的
        return .01;
    }
    else{
        return 15;
    }
    
}
//尾视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section ==1) {
        return 70;
    }
    else if  (section ==5){
        return 15;
    }
    return 0.01;
}
#warning mark  坑爹的headerview黏性
//坑爹的设置。。。。。
//IOS 去除 tableView 中 headerView 吸附头部，不整体滚动
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView ==self.tableView) {
//        
////        CGSize size = scrollView.contentSize;
////        size.width = 0;
////        scrollView.contentSize = size;
////        
//        
//        CGFloat sectionHeaderHeight = 15; //sectionHeaderHeight
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=-64) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 64, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 64, 0, 0);
//        }
//    }
//}


//头视图样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return nil;
        
    }else{
        return [[PersonageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    }
    
}
//尾视图样式
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    if (section ==5) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        return view;
    }
    if (section ==1) {
        
        return [[PersonageFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
     
    }
    return nil;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==2) {
        return 2;
    }else if(section ==3){
        return 4;
    }
    else if(section ==4){
        return 3;
    }
    else
        return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        cell.username.text = @"Catherine";
        NSArray *array = [UIFont familyNames];
        cell.username.font = [UIFont fontWithName:array[45] size:16];
        cell.personality.text = @"天要下雨";
        
        cell.pushImageView.image = [UIImage imageNamed:@"stickers_icon_forward@2x.png"];
        cell.iconImageView.image = [UIImage imageNamed:@"icon_Club_users@3x.png"];
        cell.iconImageView.layer.cornerRadius =14;
        return cell;
        
    }
    
    
    
     SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
    NSInteger count =0;
    for (NSInteger i = 0; i <indexPath.section; i++) {
        
        NSInteger temp = [self.rowsArray[i] integerValue];
        
        count +=temp;
        
    }
    count =count + indexPath.row+1;
    cell.iconImageView.image =[UIImage imageNamed:self.imageArray[count-1]];
    cell.pushImageView.image = [UIImage imageNamed:@"stickers_icon_forward@2x.png"];
    cell.tLabel.text =self.labelText[count-1];
    
    
    
    if (indexPath.section ==2 &&indexPath.row==0) {
        
        UIImageView *giftView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-cell.pushImageView.width-30-20, 7.5, 25, 25)];
        giftView.image = [UIImage imageNamed:@"icon_coupon_guide@2x.png"];

        [cell.contentView addSubview:giftView];
        
        UILabel *giftLabel = [[UILabel alloc] initWithFrame:CGRectMake(giftView.left-5-100, 15, 100, 10)];
        giftLabel.text = @"堆糖商店新人礼包";
        giftLabel.textColor = [UIColor grayColor];
        giftLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:giftLabel];
        
        
    }
    
    return cell;
    
}

#pragma mark 选择单元格

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消高亮选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        MyselfViewController *myself = [[MyselfViewController alloc] init];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myself animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (indexPath.section ==5) {
        
        AddFriendsTableViewController *add = [[AddFriendsTableViewController alloc] init];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:add animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    
    
}

@end
