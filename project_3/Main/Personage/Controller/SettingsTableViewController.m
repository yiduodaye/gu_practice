//
//  SettingsTableViewController.m
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "Common.h"
#import "SettingsTableViewCell.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import "AccountManagerViewController.h"
#import "AccountSafetyViewController.h"
#import "AboutViewController.h"
@interface SettingsTableViewController ()<UIAlertViewDelegate>{
    NSArray *labelNameArray;
    UIProgressView *progressView;
    NSTimer *timer;
    NSInteger seconds;
}

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    seconds =20;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    self.navigationItem.title = @"设置";
    
    
    [self _setBackBarButton];

    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

  
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
    labelNameArray = @[@"意见反馈",@"去 App Store给我们评五星",@"关于我们"];
  
   
}

- (void)_setBackBarButton{
    
    /*
     navigation controller按照以下3条顺序更改导航栏的左侧按钮。
     1、如果B视图有一个自定义的左侧按钮（leftBarButtonItem），则会显示这个自定义按钮；
     2、如果B没有自定义按钮，但是A视图的backBarButtonItem属性有自定义项，则显示这个自定义项；
     3、如果前2条都没有，则默认显示一个后退按钮，后退按钮的标题是A视图的标题。
     */
    
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


-(void)backToController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)progressChange{
    

    seconds --;
    progressView.progress +=0.05;
    
    if (seconds ==0) {
        [timer invalidate];
        progressView.hidden =YES;

      //弹出一个土司，放在那里。最好放在window上,在清除缓存的时候切换控制器，会看不到吐司显示。
        _hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:_hud];
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        // 设置style
        _hud.mode = MBProgressHUDModeCustomView;
        
       // _hud.delegate = self;
        _hud.labelText = @"清理完成";
        
        [_hud show:YES];
        [_hud hide:YES afterDelay:1];

        
      // 重置timer.
        timer =nil;
        progressView.progress =0;
        seconds =20;
        
        //真的清理图片内存
//        NSUInteger flieSize = [[SDImageCache   sharedImageCache]getSize];
        


        [[SDImageCache sharedImageCache]clearDisk];
       
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==2) {
        return 3;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   SettingsTableViewCell *cell = [[ SettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"defaultCell"];
    if (indexPath.section ==0 ) {
          cell.pushImageView.image = [UIImage imageNamed:@"stickers_icon_forward@2x.png"];
        cell.label.text =@"账号与安全";
    }
    
    if (indexPath.section ==1) {
        cell.label.text = @"清除图片缓存";
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, (cell.height-2)/2,kScreenWidth/3-20 , 2)];
        progressView.hidden =YES;
        progressView.progress = 0;
        [cell.contentView addSubview:progressView];
        
        
    }
    
    if (indexPath.section ==2) {
        cell.label.text = labelNameArray[indexPath.row];
        cell.pushImageView.image = [UIImage imageNamed:@"stickers_icon_forward@2x.png"];
    }
   
    if (indexPath.section ==3) {
        
        cell.exitLabel.text = @"退出当前账号";
        cell.exitLabel.textColor =[UIColor redColor];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==3 ) {
        
        //取消点击高亮状态，因为不需要弹出视图
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"确定注销当前账号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil
                               ];
  
        [alter show];
 
    }
    
    if (indexPath.section ==1) {
        NSLog(@"清除缓存");

        
      progressView.hidden =NO;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //容错，不然多次点击开启多个timer
        if (timer ==nil) {
                  timer =  [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(progressChange) userInfo:nil  repeats:YES];
        }
    }
    
    
    if(indexPath.section ==0){
        
        //如果没登录，直接弹回登录界面。
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([user objectForKey:@"acount" ]!= nil && [user objectForKey:@"pwd"] != nil) {
            
            //否则，到账号管理界面。
            AccountSafetyViewController *safy = [AccountSafetyViewController alloc];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:safy animated:YES];
            
            
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
    
    if (indexPath.section ==2) {
        
        if (indexPath.row==2) {
            
            AboutViewController *about = [[AboutViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:about animated:YES];
            
        }
        
        
        
    }
    
    
    
}

#pragma mark 警告视图的代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"acount"];
        [user removeObjectForKey:@"pws"];
         NSLog(@"注销完成");
    }
    
}



@end
