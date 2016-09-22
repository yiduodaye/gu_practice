//
//  LoginViewController.h
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputView;
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)UIView *bgView;
//两个输入框，提出来为了方便键盘的监听
@property(nonatomic,strong)InputView *view1;
@property(nonatomic,strong)InputView *view2;
@property(nonatomic,strong) UIButton *button ;
@end
