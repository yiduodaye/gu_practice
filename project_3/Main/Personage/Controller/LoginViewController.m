//
//  LoginViewController.m
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
#import "InputView.h"

#define testAccount @"123456"
#define testPassword @"123456"

@interface LoginViewController (){
    
    NSArray *appImage;
    NSArray *appNameArray;
    NSArray *fontArray;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    self.navigationItem.title = @"登录";
    [self _loadData];
    [self _setBackBarButton];
    [self _setRightBarButton];
    [self _loadSubview];
    [self _addGesture];
    
  
#pragma mark 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyBoardShow:(NSNotification *)notification{
    //NSLog(@"%@",notification.userInfo);
    CGRect rect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat height = rect.size.height;
    self.view.transform =CGAffineTransformMakeTranslation(0, -height+kTabBarHeight);

    
}


- (void)_addGesture{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard:)];
    
    
    [self.view addGestureRecognizer:tap];
    
}


- (void)hiddenKeyboard:(UITapGestureRecognizer *)tap{
    
    if ([self.view1.text isFirstResponder] ) {
        [self.view1.text resignFirstResponder];
        [UIView animateWithDuration:0.4 animations:^{
            self.view.transform =CGAffineTransformIdentity;
        }];
        return;
    }
    else if([self.view2.text isFirstResponder]){
        [self.view2.text resignFirstResponder];
        [UIView animateWithDuration:0.4 animations:^{
            self.view.transform =CGAffineTransformIdentity;
        }];
       
    }
    
  
    
}

- (void)_loadData{
    appImage =@[@"login_icon_sina@2x.png",@"login_icon_qq@2x.png",@"login_icon_weixin@2x.png"];
    appNameArray = @[@"新浪微博",@"Q Q",@"微信"];
    fontArray = [UIFont familyNames];
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
    [button setImage:[UIImage imageNamed:@"icon_close_dark@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem =backButton;
    
    
    
    
    
}


- (void)_setRightBarButton{
    //自定义右侧按钮
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame =CGRectMake(0, 0, 50, 30);
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    
    [_button setFont:[UIFont systemFontOfSize: 17]];
    
    [_button setUserInteractionEnabled:NO];
    [_button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.rightBarButtonItem =rightButton;

    
}


- (void)_loadSubview{
    
    //使用社交网络账号登录
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 64+25, kScreenWidth/2, 10)];
    [self.view addSubview:label1];
    label1.text =@"使用社交网络账号登录";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor grayColor];
    
    
    //跳转其他APP登录的View
    
    UIView *getView = [[UIView alloc] initWithFrame:CGRectMake(0, label1.bottom+15, kScreenWidth, 80)];
    getView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:getView];
    CGFloat viewWidth = kScreenWidth/3;
    for (NSInteger i =0;  i <3; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i *viewWidth, 0, viewWidth, getView.height)];
        [getView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       [button setImage:[UIImage imageNamed:appImage[i]] forState:UIControlStateNormal];
       // [button setBackgroundImage:[UIImage imageNamed:appImage[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake((view.width-30)/2, 15, 40, 40);
      
        
        
        button.tag =100+i;
        [view addSubview:button];
        
        
        UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(button.left-5, button.bottom   , button.width+10, 18)];
        appName.text = appNameArray[i];
        appName.textAlignment = NSTextAlignmentCenter;
        appName.font = [UIFont fontWithName:fontArray[40] size:12];
        [view  addSubview:appName];
      
    
        
        
    }
    
    
    
    
    //使用堆糖账号登录
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, getView.bottom+50, kScreenWidth/2, 10)];
    [self.view addSubview:label2];
    label2.text =@"使用堆糖账号登录";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor grayColor];
    
    
    
    //输入框
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, label2.bottom+15, kScreenWidth, 2*40)];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    //第一个输入框
    self.view1 = [[InputView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) ispassword:NO];
    _view1.text.placeholder =@"输入手机号/邮箱/昵称";
    [loginView addSubview:_view1];
    //第二个输入框
    self.view2 = [[InputView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 40) ispassword:YES];
    _view2.text.placeholder=@"输入密码";
    [loginView addSubview:_view2];
    
    //设置代理;
    
    _view1.text.delegate = self;
    _view2.text.delegate = self;
    
    
    
    //找回密码(这个可以点击的，要么子类化添加手势，要么用button)
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, loginView.bottom+15, kScreenWidth/2, 10)];
    [self.view addSubview:label3];
    label3.text =@"找回密码";
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor colorWithRed:125/255.0 green:206/255.0 blue:250/255.0 alpha:1];
    
    
    
    
    
}

- (void)login{
    
    [self textFieldShouldReturn:self.view1.text];
}

- (void)backToController {
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma  mark  textfield代理



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"键盘弹出");
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSLog(@"确定");
    
    if ([self.view1.text.text isEqualToString:@""]||[self.view2.text.text isEqualToString:@""]||
        self.view1.text.text == nil||
        self.view2.text.text == nil) {
        
        UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"账号或者密码不能为空" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil
                              ];
        //self.view.transform =CGAffineTransformIdentity;
        [alter1 show];
        
        
    }
    
    else if ([self.view1.text.text isEqualToString:testAccount] && [self.view2.text.text isEqualToString:testPassword]){
        //登录成功
        //1.键盘消失。
            [textField resignFirstResponder];
            [UIView animateWithDuration:0.4 animations:^{
                self.view.transform =CGAffineTransformIdentity;
            }];
        //2.存储账号密码.
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.view1.text.text forKey:@"acount"];
        [user setObject:self.view2.text.text forKey:@"pwd"];
        
        //3.Pop回去
        [self.navigationController popToRootViewControllerAnimated:YES];
        //4.登录提示view消失。
        
        //这一步在主控制器中的viewwillapear中做
        
    }
    else {
    UIAlertView *alter2 = [[UIAlertView alloc] initWithTitle:@"账号或者密码错误，请从新输入" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil
                          ];
    
        
        
    [alter2 show];
    
    
    
    }

    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length != 0
   ) {
        
        
        [_button setTitleColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [_button setUserInteractionEnabled:YES];
        
    }
    else if(self.view1.text.text == NULL || self.view2.text.text == NULL ||
            [self.view1.text.text isEqualToString:@""]||
            [self.view2.text.text isEqualToString:@""]){
          [_button setTitleColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
         [_button setUserInteractionEnabled:NO];
        
    }
    
    return YES;
}

@end
