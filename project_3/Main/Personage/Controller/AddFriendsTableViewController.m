//
//  AddFriendsTableViewController.m
//  project_3
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AddFriendsTableViewController.h"
#import "Common.h"
#import "SecondTableViewCell.h"
#import "HotPeopleTableView.h"
#import "FriendsTableViewCell.h"

@interface AddFriendsTableViewController (){
    NSArray *iconImageArray;
    NSArray *labelNameArray;
    UITextField *searchText;
   
}

@end

@implementation AddFriendsTableViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
      [self _loadTitleView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self _removeTitleView];
}

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets =YES;
    [super viewDidLoad];
    [self _loadData];
  
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    
    [self _setBackBarButton];
    [self _loadTableView];
    [self _loadHotTableView];

    
}
- (void)_loadData {
    iconImageArray = @[@"friend_weibo@2x.png",@"friend_weixin@2x.png",@"friend_qq@2x.png",@"friend_book@2x.png"];
    labelNameArray = @[@"添加新浪微博好友",@"添加微信好友",@"添加QQ好友",@"添加通讯录好友"];
    
}

- (void)_loadTableView{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //tableView的头视图(不是组头视图)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    searchView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:searchView];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15/2, 25, 25)];
    searchImageView.image = [UIImage imageNamed:@"tab_icon_explore@2x"];
    [searchView addSubview:searchImageView];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(searchImageView.right+15, 15/2, kScreenWidth-searchImageView.width-15*2, 25)];
    [searchView addSubview:searchText];
    searchText.placeholder =@"搜索昵称添加好友";
    
    
    self.tableView.tableHeaderView =headerView;
    
    
    
    
}

- (void)_loadHotTableView
{
    //如果是达人，跳转
    //要用self.view.bounds，用frame会枪侠偏移20
    self.hotPeopleTableView = [[HotPeopleTableView alloc] initWithFrame:self.view.bounds];

    [self.view addSubview:self.hotPeopleTableView ];
    self.hotPeopleTableView.hidden=YES;

    
}

- (void)_loadTitleView {
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-120)/2, 9, 120, 30)];
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:255/255.0 alpha:1];
    [self.navigationController.navigationBar addSubview: _titleView];
    _titleView.layer.cornerRadius =4;
    _titleView.layer.masksToBounds =YES;
    
    UIButton *friendsButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    friendsButton.frame = CGRectMake(0, 0, 60, 30);
    [friendsButton setTitle:@"好友" forState:UIControlStateNormal];
    [friendsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    friendsButton.backgroundColor = [UIColor grayColor];
    [friendsButton setFont:[UIFont systemFontOfSize:13]];
    friendsButton.selected =YES;
    [friendsButton addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
    friendsButton.tag =201;
    [self.titleView addSubview:friendsButton];
    
    UIButton *hotPeopleButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    hotPeopleButton.frame = CGRectMake(friendsButton.right, 0, 60, 30);
      [hotPeopleButton setFont:[UIFont systemFontOfSize:13]];
    [hotPeopleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [hotPeopleButton setTitle:@"达人" forState:UIControlStateNormal];
    hotPeopleButton.backgroundColor = [UIColor whiteColor];
    [hotPeopleButton addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
    hotPeopleButton.tag =202;
    [self.titleView addSubview:hotPeopleButton];
    
    
}

- (void)chooseType:(UIButton *)button {
    if (button.selected ) {
        return;
    }
    
    else {
    
        
        //设置选中状态
        for (NSInteger i =1; i<3; i++) {
            UIButton *btn = (UIButton *)[self.titleView viewWithTag:i+200];
            
            if(button != btn){
                
                btn.selected =NO;
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                
                
            }
            
            else{
                btn.selected =YES;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor grayColor];
          
            }
            
            
            
            if (i==2 &&btn.selected) {
                self.hotPeopleTableView.hidden =NO;
                
            }
            else{
               self.hotPeopleTableView.hidden =YES;
                
            }
            
        }
    
        
        //选择的不是同一按钮下，改变颜色
        
        
        
    }
    
    
    
}

- (void)_removeTitleView{
    if (self.titleView != nil) {
        [self.titleView removeFromSuperview];
    }
    
}

- (void)_setBackBarButton{
    

    
    //隐藏自带的
    self.navigationItem.hidesBackButton =YES;
    
    
    //自定义左侧按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 30, 30);
    //   button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"icon-back_highlighted@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem =backButton;
    
    
}

- (void)backToController{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendsTableViewCell *cell = [[ FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstTypeCell"];
    
    cell.pushImageView.image = [UIImage imageNamed:@"stickers_icon_forward@2x.png"];
    cell.iconImageView.image = [UIImage imageNamed:iconImageArray[indexPath.row]];
    cell.typeName.text = labelNameArray[indexPath.row];
    cell.typeName.font = [UIFont systemFontOfSize:13];
    return cell;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([searchText  isFirstResponder]) {
        [searchText resignFirstResponder];
    }
}

@end
