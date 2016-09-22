//
//  FRGHeaderReusableView.m
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import "FRGWaterfallHeaderReusableView.h"
#import "Common.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "SubscribViewController.h"
#import "ClickView.h"
#define kViewGap 5
#define kSuperGap 10

@interface FRGWaterfallHeaderReusableView(){
    UIScrollView *scroller;
    NSMutableArray *labelNames;
    NSMutableArray *imgNames;
    NSMutableArray *targets;
 
}

@end

@implementation FRGWaterfallHeaderReusableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //[self _loadScrollerView];
        
    }
    return self;
}

- (void)customStyle {
    [self _requestDataCustom];
}

- (void)defaultStyle{
    [self _requestDataDefault];
    
}

- (void)buttonStyle{
    [self _requestDataButton];
}
- (void)_requestDataCustom{
    
    labelNames = [[NSMutableArray alloc] init];
    imgNames  = [[NSMutableArray alloc] init];
    targets = [[NSMutableArray alloc] init];
    
    
    [DataService getThemeRequestWithNextStart:self.theme Success:^(NSArray *result, NSString *start) {
    
        for (NSDictionary *dic in result) {
            
            NSString *target = [dic objectForKey:@"target"];
            [targets addObject:target];
            
            
            NSString *image = [dic objectForKey:@"image"];
            [imgNames addObject:image];
            
            
            NSString *name = [dic objectForKey:@"name"];
            [labelNames addObject:name];
   
            
        }
        
        
        [self _loadScrollerView];
        
    } failure:^(NSError *error) {
        NSLog(@"请求搜索主题失败");
    }];
    
    
    
}

- (void)_requestDataDefault{
    
    labelNames = [[NSMutableArray alloc] init];
    imgNames  = [[NSMutableArray alloc] init];
    targets = [[NSMutableArray alloc] init];
    
    [DataService getDefaultThemeRequestWithNextStart:nil Success:^(NSArray *result, NSString *start) {
        
      //得到需要的数据
        NSDictionary *HotPicturetheme =result[0];
        NSArray *group_items = HotPicturetheme[@"group_items"];

        for (NSDictionary *dic in group_items) {
            
            
            NSString *target = [dic objectForKey:@"target"];
            [targets addObject:target];
            
            
            NSString *image = [dic objectForKey:@"icon_url"];
            [imgNames addObject:image];
            
            
            NSString *name = [dic objectForKey:@"name"];
            [labelNames addObject:name];
            
        }
        
        
        [self _loadScrollerView];
        
    } failure:^(NSError *error) {
        NSLog(@"请求默认主题失败");
    }];
    
}

- (void)_requestDataButton{
    
        
    if (self.butonNames.count !=0 &&self.image_url !=nil) {
        [self _loadheaderView];
        
    }
        
    
        

    
    
    
    
}

- (void)_loadScrollerView{
    

    
   scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    scroller.backgroundColor = [UIColor whiteColor];
    [self addSubview:scroller];
    [self _createSubView];
    scroller.showsHorizontalScrollIndicator =NO;
    scroller.showsVerticalScrollIndicator =NO;
    
}

- (void)_createSubView {
    
    
    CGFloat viewWidth =(kScreenWidth-10)/4;
    CGFloat imgWidth = viewWidth -kViewGap*2;
    CGFloat imgHeight = 100 -kViewGap*2 -2*kSuperGap-15;
    for (NSInteger i =0; i <imgNames.count; i++) {
      ClickView *view = [[ClickView alloc] initWithFrame:CGRectMake(i *viewWidth+5, 0, viewWidth, 100)];
        view.theme =labelNames[i];
        view.target =targets[i];
        [scroller addSubview:view];
        
        view.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTo:)];
        [view addGestureRecognizer:tap];
        
        
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, imgWidth, imgHeight)];
        imgView.backgroundColor = [UIColor whiteColor];
        [view addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgNames[i]]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.left, imgView.bottom +8, imgWidth, 15)];
        label.font = [UIFont systemFontOfSize:11];
        label.text = labelNames[i];
        [view addSubview:label];
        
        
        
    }
    
    scroller.contentSize = CGSizeMake(viewWidth*imgNames.count, 0);
    
}


- (void)imageStyle {
    
    
    [DataService getSubscribTitleRequestWithNextStart:self.theme Success:^(NSDictionary *result) {

        
        
        //创建视图
        self.layer.masksToBounds=YES;
        self.clipsToBounds=NO;
        UIImageView *bgView= [[UIImageView alloc] initWithFrame:CGRectMake(0,-64 , kScreenWidth, _height+64)];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [bgView sd_setImageWithURL:[NSURL URLWithString:self.image_url]];
      
        [self addSubview:bgView];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:bgView.bounds];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        [bgView addSubview:toolbar];

        
        
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-50)/2, 10, 50, 50)];
        [self addSubview:self.imgView];
        NSString *path = result[@"image"];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:path]];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake((self.width-120)/2, self.imgView.bottom+10, 120, 15)];
        self.label1.text = result[@"name"];
        self.label1.textColor = [UIColor whiteColor];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.font= [UIFont systemFontOfSize:15];
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.label1.bottom+10, self.width-20*2, self.bottom-self.label1.bottom)];
        self.label2.textColor= [UIColor whiteColor];
        self.label2.text = result[@"desc"];
        self.label2.textAlignment= NSTextAlignmentCenter;
        self.label2.numberOfLines =0;
        self.label2.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label2];
        
        
        
  
        
        
        
        
        
        
        
        
            } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)_loadheaderView{
    
    //先计算头视图的高度
    //64+10+(buttonHeights+10)*i+40
    
    CGFloat lenght = 10;
    CGFloat row = 0;
    
    for (NSInteger i =0; i<self.butonNames.count ; i++) {
        
        NSString *name= self.butonNames[i];
        NSString *sd = @"#";
        NSString *button_name = [sd stringByAppendingString:name];
        CGSize buttonSize = [self getLabelRectFromString:button_name andFont:14];
        CGFloat buttonWidth =buttonSize.width+20;
        
        
        if ((lenght +10+buttonWidth+20 ) > kScreenWidth){
            
            lenght =10;
            row++;
            
            
        }
        
        
        
        lenght +=10;
        lenght +=buttonWidth;
        

        
    }
    
    
    //加载视图
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
   
    [self addSubview:bgView];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height-40)];
    
   
    
    
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.image_url]];
    imgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [bgView addSubview:imgView];
    
    
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:imgView.frame];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [imgView addSubview:toolbar];
//    UIView *blackView= [[UIView alloc]initWithFrame:bgView.frame];
//    blackView.backgroundColor = [UIColor blackColor];
//    blackView.alpha = 0.4;
//    [bgView addSubview:blackView];
    
    
    //label
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.bottom, bgView.width, 40)];
    [bgView addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake((bgView.width/2-20)/2, 10, 20, 20);
    [button1 setImage:[UIImage imageNamed:@"icon_album_view_double_highlight@2x.png"] forState:UIControlStateNormal];
    [whiteView addSubview:button1];
    
    UIView *seperateView = [[UIView alloc]initWithFrame:CGRectMake(bgView.width/2-1, 4, 1, 40-8)];
    seperateView.backgroundColor = [UIColor grayColor];
    [whiteView addSubview:  seperateView];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake((bgView.width/2)+(bgView.width/4)-10, 10, 20, 20);
    [button2 setImage:[UIImage imageNamed:@"icon_category_album@2x.png"] forState:UIControlStateNormal];
    [whiteView addSubview:button2];
    
    
    CGFloat lenghts = 0;
    NSInteger rows =0;

    for (NSString *name in self.butonNames) {
        
        
        NSString *sd = @"#";
        NSString *button_name = [sd stringByAppendingString:name];
        CGSize buttonSize = [self getLabelRectFromString:button_name andFont:14];
        CGFloat buttonWidth =buttonSize.width+20;
        if ((lenghts +10+buttonWidth+20 ) > kScreenWidth){
            
            lenghts =10;
            rows++;
            
            
        }
        
        
        
        
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame= CGRectMake(10+lenghts, 64+10+rows*(30+10), buttonWidth, 30);
        [imgView addSubview:button];
        [button setTitle:button_name forState:UIControlStateNormal];
        
        [button setFont:[UIFont systemFontOfSize:14]];
        button.layer.cornerRadius=5;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth=1;
        
        lenghts +=10;
        lenghts +=buttonWidth;
        
    }
    
    
    
    
}

- (void)clickTo:(UITapGestureRecognizer *)tap {
   
    ClickView *bView =(ClickView*) tap.view;
    
    NSString *target = bView.target;
    
    NSRange range = [target rangeOfString:@"id="];
    NSString *cate_id;
    if (range.length !=0) {
        cate_id = [target substringFromIndex:range.location+3];
    }
  
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    
    SubscribViewController *theme =[sb instantiateViewControllerWithIdentifier:@"subscribController"];
    
    UIViewController *controller = [self getViewController];
    theme.condition=cate_id;
    theme.theme = bView.theme;
    if(range.length!=0 ){
        controller.hidesBottomBarWhenPushed=YES;
        [controller.navigationController pushViewController:theme animated:YES ];
      
    }
    

    
    
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

//计算文本宽度

- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
}///

@end
