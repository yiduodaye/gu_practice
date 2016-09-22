//
//  SearchViewController.m
//  project_3
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchViewController.h"
#import "Common.h"
#import "SearchTableViewController.h"


@interface SearchViewController (){
    
    UIImageView *navigationBgImageView;
    UIButton *cancelButton;
    UITextField *textfield;
    
}
@property(nonatomic,strong)NSArray *hotSearchArray;

@end

@implementation SearchViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _loadNavigationSubView];   
    
}




- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [navigationBgImageView removeFromSuperview];
    [cancelButton removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    
    
    [self _loadData];
    [self _loadScrollView];
    [self _loadView1];
    [self _loadView2];
    
    
}


//懒加载

- (NSArray *)hotSearchArray {
    
    if (_hotSearchArray == nil) {
        self.hotSearchArray =@[@"微微一笑很倾城",@"秋天",@"小皮鞋",@"灰姑娘与四骑士",@"早餐",@"钢笔字",@"开衫",@"九月",@"发型"];
    }
    return _hotSearchArray;
}

- (void) _loadNavigationSubView{
    
    [self.navigationItem setHidesBackButton:YES];
    
   cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelButton setFont:[UIFont systemFontOfSize:14]];
    
    cancelButton.frame = CGRectMake(kScreenWidth-10-30, (kNavigationBarHeigth-20-30)/2-4, 30  , 30);
    [self.navigationController.navigationBar addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    navigationBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-10-cancelButton.width-10*2 ,kNavigationBarHeigth-8*2-kStatusBar )];
   
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
    
    
    textfield = [[UITextField alloc] initWithFrame:CGRectMake(5+magnifyView.width, 5, navigationBgImageView.width-magnifyView.width-20, magnifyView.height)];
    [navigationBgImageView addSubview:textfield];
    textfield.placeholder=@"搜索感兴趣的内容...";
    textfield.textColor = [UIColor grayColor];
    [textfield setEnabled:YES];
    [textfield becomeFirstResponder];
    textfield.delegate =self;

    
    
}

- (void)_loadView1{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 15)];
    label.text = @"最近搜索";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view1 addSubview:label];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame=CGRectMake(kScreenWidth-10-80, 15, 80, 15);
    [clearBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearBtn setTitle:@"清除记录" forState:UIControlStateNormal];
    [clearBtn setFont:[UIFont systemFontOfSize:15]];
    [self.view1 addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearAll:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(10, label.bottom+15, kScreenWidth-10, 1)];
    grayLine.backgroundColor = [UIColor grayColor];
    [self.view1 addSubview:grayLine];
    
    //添加默认的按钮
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *array = [user objectForKey:@"recentSearch"];
    //动态显示一排按钮。
    CGFloat length=0;
    for (NSString *name in array) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize buttonSize = [self getLabelRectFromString:name andFont:14];
        CGFloat viewTap =10;
        button.frame =CGRectMake(length+viewTap, grayLine.bottom+10, buttonSize.width+10, 30);
        button.layer.cornerRadius=5;
        button.layer.borderWidth=1;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        [button setTitle:name forState:UIControlStateNormal];
        [button setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
        
        length +=10+button.width;
        
        if (length <kScreenWidth) {
            [self.view1 addSubview:button];
        }
        
        
    }
    
    
    
}

- (void)_loadView2{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,100, 15)];
    label.text = @"热门搜索";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view2 addSubview:label];
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(10, label.bottom+15, kScreenWidth-10, 1)];
    grayLine.backgroundColor = [UIColor grayColor];
    [self.view2 addSubview:grayLine];
    
    //加载热门按钮
    CGFloat lenght = 0;
    NSInteger row =0;
    
    for (NSString *name in self.hotSearchArray) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize buttonSize = [self getLabelRectFromString:name andFont:14];
        CGFloat viewTap =10;
      
        if (lenght+viewTap+buttonSize.width+10 >kScreenWidth -10) {
        
            row ++;
            lenght =0;
        }
        
        button.frame =CGRectMake(lenght+viewTap, grayLine.bottom+10+row*(30+10), buttonSize.width+10, 30);
        button.layer.cornerRadius=5;
        button.layer.borderWidth=1;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        [button setTitle:name forState:UIControlStateNormal];
        [button setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
          lenght +=button.width+viewTap;
        [self.view2 addSubview:button];


        
        
    }
    
}

- (void)clickTo:(UIButton *)button{

    
    //点击进入详细
      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    SearchTableViewController *searchTable = [sb instantiateViewControllerWithIdentifier:@"waterfallController_1"];
    //还要将text传递到下一层控制器中，使得这个参数能够拼接到url中，精确请求查询数据
    searchTable.condition =button.titleLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchTable animated:YES];
    
    //储存记录
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[user objectForKey:@"recentSearch"] mutableCopy];
    if (array.count<10) {
        [array insertObject:button.titleLabel.text atIndex:0];
        [user setObject:array forKey:@"recentSearch"];
    }
    
    
}

- (void)clearAll:(UIButton *)button{
    NSLog(@"清除");
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[user objectForKey:@"recentSearch"] mutableCopy];
    [array removeAllObjects];
    [user setObject:array forKey:@"recentSearch"];
    
    
}


- (void)backTo:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)_loadData{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"recentSearch"] ==nil) {
        NSMutableArray *searchArray =[[NSMutableArray alloc]initWithCapacity:10];
        [user setObject:searchArray forKey:@"recentSearch"];
    }

    
    
    
}

- (void)_loadScrollView{
    
    UIScrollView *scroll =[[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    scroll.scrollEnabled=YES;
    scroll.contentSize =CGSizeMake(0, kScreenHeight+80);
    scroll.showsVerticalScrollIndicator=NO;
    scroll.delegate=self;
    [self.view addSubview:scroll];
    
    _view1=[[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 100)];
    _view1.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *array = [user objectForKey:@"recentSearch"];
    if (array.count==0) {
        _view1.frame =CGRectZero;
        
    }
    else{
        [scroll addSubview:_view1];
    }
    _view2=[[UIView alloc] initWithFrame:CGRectMake(0, self.view1.bottom+20, kScreenWidth, 180)];
    _view2.backgroundColor = [UIColor whiteColor];
    
    
    
    [scroll addSubview:_view2];
}
- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
}
#pragma mark textfield代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[user objectForKey:@"recentSearch"] mutableCopy];
    if (array.count<10) {
        [array insertObject:textField.text atIndex:0];
        [user setObject:array forKey:@"recentSearch"];
    }
    
    //点击进入详细
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    SearchTableViewController *searchTable = [sb instantiateViewControllerWithIdentifier:@"waterfallController_1"];
    searchTable.condition = textField.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchTable animated:YES];
    
    
    return YES;
}

#pragma mark 滑动视图代理

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [textfield resignFirstResponder];
}

@end
