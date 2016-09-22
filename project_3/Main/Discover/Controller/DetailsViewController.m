//
//  DetailsViewController.m
//  project_3
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailsViewController.h"
#import "DataService.h"
#import "Common.h"
#import "DetailsModel.h"
#import "DetailsLayout.h"
#import "UIImageView+WebCache.h"
#import "Advertise.h"
#import "Advertise.h"


@interface DetailsViewController ()

@property(nonatomic,strong)DetailsModel *Dmodel;
@property(nonatomic,strong)DetailsLayout *layout;

@end

@implementation DetailsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"详情";
    [self _setBackBarButton];
    [self _requestData];
    
}

- (DetailsModel *)Dmodel {
    if (_Dmodel ==nil) {
        _Dmodel  = [[DetailsModel alloc] init];
    }
    return _Dmodel;
}

- (DetailsLayout *)layout {
    if (_layout == nil) {
        _layout = [[DetailsLayout alloc] init];
    }
    return _layout;
}



- (void)_requestData{
    
    [DataService getDetailsRequestWithNextStart:self.numberID Success:^(NSDictionary *result) {
        NSDictionary *photo = result[@"photo"];
        NSString *realPath =photo[@"path"];
        NSString *path =[realPath substringWithRange:NSMakeRange(0, realPath.length-5)];
        self.Dmodel.path =path;
        self.Dmodel.imgWidth = photo[@"width"];
        self.Dmodel.imgHeight = photo[@"height"];
        
        NSDictionary *album = result[@"album"];
        self.Dmodel.name = album[@"name"];
        
        self.Dmodel.msg = result[@"msg"];
        
        self.Dmodel.source_shortcut_icon =result[@"source_shortcut_icon"];
        self.Dmodel.source_title = result[@"source_title"];
        
        NSDictionary *sender = result[@"sender"];
        self.Dmodel.avatar =sender[@"avatar"];
        self.Dmodel.username =sender[@"username"];
        
        
        self.Dmodel.add_datetime =result[@"add_datetime"];
        self.Dmodel.favorite_count = result[@"favorite_count"];
        
        
        //数组1
        NSMutableArray *likes= [NSMutableArray array];
        NSArray *dic_like =result[@"top_like_users"];
        for (NSDictionary *dic in dic_like) {
            NSString *icon_url = dic[@"avatar"];
            [likes addObject:icon_url];
        }
        
        self.Dmodel.top_like_users =likes;


        //数组2;
        self.Dmodel.related_albums=result[@"related_albums"];
        
        //tags
        NSMutableArray *tags = [NSMutableArray array];
        NSDictionary *tag = result[@"tags"];
        for (NSDictionary *dic in tag) {
            
            NSString *name = dic[@"name"];
            [tags addObject:name];
            
        }
        
        self.Dmodel.tags =tags;
        
        
        //到此model值传递完毕
        //调用setModel时候就计算高度.
        self.layout.model =self.Dmodel;
        
        
        //计算高度完成，然后根据这里的frame加载子视图，滑动视图
        //看下面的代码写在哪里比较好。
     
        [self addSubViews];
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}


- (void)addSubViews{
    //layout已经有值了.
    //因为不用系统自动布局，所以添加64高度.
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scroll];
 
    scroll.contentSize=CGSizeMake(kScreenWidth, self.layout.scrollViewHeight+80);
    scroll.showsVerticalScrollIndicator =NO;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.backgroundColor =
    self.view.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    

    UIImageView *imgView =[[UIImageView alloc]initWithFrame:self.layout.imageFrame];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.Dmodel.path]];
    
    
    
    
    
   
    [scroll addSubview:imgView];
    
    
    UIView *msgView = [[UIView alloc]initWithFrame:self.layout.msgFrame];
    msgView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:msgView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, msgView.width-20, msgView.height-20)];
    msgLabel.text =self.Dmodel.msg;
    msgLabel.numberOfLines=0;
    msgLabel.font = [UIFont systemFontOfSize:14];
    [msgView addSubview:msgLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, msgView.height-1, msgView.width-10, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [msgView addSubview:lineView];
    
    //3.
    UIView *titleView = [[UIView alloc] initWithFrame:self.layout.titleFrame];
    titleView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:titleView];
    
    UIImageView *titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (titleView.height-14)/2, 14, 14)];
    [titleIcon sd_setImageWithURL:[NSURL URLWithString:self.Dmodel.source_shortcut_icon]];
    [titleView addSubview:titleIcon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleIcon.right+4, (titleView.height-14)/2, titleView.width-20-titleIcon.width-10, 14)];
    titleLabel.text= self.Dmodel.source_title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    [titleView addSubview:titleLabel];
    
    UIView *lineView0 = [[UIView alloc] initWithFrame:CGRectMake(10, titleView.height-1, titleView.width-10, 1)];
    lineView0.backgroundColor = [UIColor grayColor];
    [titleView addSubview:lineView0];
    
    //4.
    UIView *tagsView = [[UIView alloc] initWithFrame:self.layout.tagsFrame];
    [scroll addSubview:tagsView];
    tagsView.backgroundColor = [UIColor whiteColor];
    CGFloat lenght1 =10;
    CGFloat lenght2 =10;
    for (NSString *str in self.Dmodel.tags) {
        
        NSString *str1 = @"#";
        NSString *tag = [str1 stringByAppendingString:str];
        CGSize btnTextWidth = [self getLabelRectFromString:tag  andFont:14];
        //加前后距离
        CGFloat btnWidth = btnTextWidth.width+20;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        button.frame = CGRectMake(lenght1, 10, btnWidth, 30);
        [button setFont:[UIFont systemFontOfSize:14]];
        [button setTitle:tag forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
         lenght1 +=btnWidth+10;
        button.layer.cornerRadius =5;
        button.layer.borderColor= [UIColor grayColor].CGColor;
        button.layer.borderWidth =1;
        
        if (lenght1 < tagsView.width) {
            [tagsView addSubview:button];
        }
        else {
            
        
            button.frame = CGRectMake(lenght2, 10+30+10, btnWidth, 30);
            lenght2 +=btnWidth+10;
            [tagsView addSubview:button];
            
        }
        
        
    }
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, tagsView.height-1, tagsView.width-10, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    [tagsView addSubview:lineView1];
    
    
    //高度为50
    UIView *userView = [[UIView alloc] initWithFrame:self.layout.userFrame];
    userView.backgroundColor= [UIColor whiteColor];
    [scroll addSubview:userView];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.layout.userFrame.size.height-36)/2, 36, 36)];
    [iconView sd_setImageWithURL:[NSURL URLWithString:self.Dmodel.avatar]];
    iconView.layer.masksToBounds=YES;
    iconView.layer.cornerRadius=18;
    [userView addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+5,iconView.top, 120, iconView.height/2)];
    nameLabel.text =self.Dmodel.username;
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
    [userView addSubview:nameLabel];
    
    UILabel *albumLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+5, iconView.top+iconView.height/2, 120, iconView.height/2)];
    NSString *str_f = @"收藏到 ";
    albumLabel.text =[str_f stringByAppendingString:self.Dmodel.name];
    albumLabel.font = [UIFont systemFontOfSize:10];
    [userView addSubview:albumLabel];
    
    //截取日期

    NSString *str_t =self.Dmodel.add_datetime;
    NSRange range =[str_t rangeOfString:@"日"];
    NSString *time;
    
    if (range.length !=0) {
        time = [str_t substringWithRange:NSMakeRange(0, range.location+1)];
    }
    else {
      time = [str_t substringWithRange:NSMakeRange(0, 2)];
    }
   
   
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(userView.right-18-100, 10, 100, 10)];
    dateLabel.text=time;
    dateLabel.textColor= [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:11];
    dateLabel.textAlignment=NSTextAlignmentRight;
    [userView addSubview:dateLabel];
    
    //攒50/60
    UIView *favourView = [[UIView alloc ]initWithFrame:self.layout.favourateFrame];
    if (self.Dmodel.top_like_users.count !=0) {
          [scroll addSubview:favourView];
    }
  
    favourView.backgroundColor = [UIColor whiteColor];
    
    UILabel *favourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 60, 20)];
    NSString *str_favour = @"赞 ";
    NSString *str_favor_count = [NSString stringWithFormat:@"%ld",self.Dmodel.top_like_users.count];
    str_favour = [str_favour stringByAppendingString:str_favor_count];
    favourLabel.text =str_favour;
    favourLabel.textColor = [UIColor grayColor];
    [favourView addSubview:favourLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 49, favourView.width-10, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [favourView addSubview:lineView2];
    CGFloat iconWidth =30;
    //能显示多少个
     NSInteger icon_count = (favourView.width-20)/(10+iconWidth);
    NSInteger counts= [self compared:icon_count-1 and:self.Dmodel.top_like_users.count];
    for (NSInteger i =0; i<counts; i++) {
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*(10+iconWidth), lineView2.bottom+15, 30, 30)];
        [iconView sd_setImageWithURL:[NSURL URLWithString:self.Dmodel.top_like_users[i]]];
        iconView.layer.cornerRadius =15;
        [favourView addSubview:iconView];
    }
    
    UIButton *iconView_more =[UIButton buttonWithType:UIButtonTypeCustom];
    iconView_more.frame=CGRectMake(10+(counts)*(10+iconWidth), lineView2.bottom+15, 30, 30);
    [iconView_more setImage:[UIImage imageNamed:@"detail_good_more@2x"] forState:UIControlStateNormal];
    [favourView addSubview:iconView_more];
    
    
    
    //view3 30/80
    UIView *albumView= [[UIView alloc] initWithFrame:self.layout.albumFrame];
    albumView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:albumView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 10)];
    aLabel.text = @"收藏到以下专辑";
    aLabel.textColor = [UIColor grayColor];
    aLabel.font = [UIFont systemFontOfSize:15];
    [albumView addSubview:aLabel];
    
    UILabel *blabel = [[UILabel alloc] initWithFrame:CGRectMake(albumView.width-10-60, 10, 60, 10)];
    blabel.textColor= [UIColor grayColor];
    blabel.textAlignment =NSTextAlignmentRight;
    blabel.font = [UIFont systemFontOfSize:14];
    NSString *album_count = [NSString stringWithFormat:@"%@",self.Dmodel.favorite_count];
    NSString *str_m = @" >";
    NSString *str_more = [album_count stringByAppendingString:str_m];
    blabel.text=str_more;
    [albumView addSubview:blabel];
    //下面的是滑动视图
    CGFloat coverWidth =110;
    UIScrollView *album_scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, albumView.width, coverWidth)];
    
    album_scrollView.contentSize =CGSizeMake((coverWidth+10)*4+10, 0);
    [albumView addSubview:album_scrollView];
    album_scrollView.showsHorizontalScrollIndicator=NO;
    album_scrollView.showsVerticalScrollIndicator=NO;
    NSInteger ns =0;
    for (NSDictionary *dic in self.Dmodel.related_albums) {
        
        NSString *name = dic[@"name"];
        NSString *covers = dic[@"covers"][0];
        NSDictionary *user = dic[@"user"];
        NSString *by = @"by ";
        NSString *username = user[@"username"];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+ns*(10+coverWidth), 0, coverWidth, coverWidth)];
        ns++;
        
        
        //[imgView sd_setImageWithURL:[NSURL URLWithString:covers]];
        //调低分辨率，使图片看起来舒服一点
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:covers]]];
        
        image = [self OriginImage:image scaleToSize:CGSizeMake(coverWidth, coverWidth)];
        imgView.image =image;
        
        
        
        
        [album_scrollView addSubview:imgView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, coverWidth-25, coverWidth-10, 10)];
        nameLabel.textColor=[UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.text =name;
        [imgView addSubview:nameLabel];
        
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, coverWidth-15, coverWidth-10, 10)];
        usernameLabel.textColor =[UIColor whiteColor];
        usernameLabel.font = [UIFont systemFontOfSize:11];
        usernameLabel.text = [by stringByAppendingString:username];
        [imgView addSubview:usernameLabel];
        
        //推广
        
        UIView *grayView = [[UIView alloc]initWithFrame:self.layout.lineFrame];
        grayView.backgroundColor= [UIColor clearColor];
        [scroll addSubview:grayView];
        
        UIView *lineView3= [[UIView alloc]initWithFrame:CGRectMake(0, grayView.height/2-1, (lineView.width-40)/2, 1)];
        lineView3.backgroundColor = [UIColor grayColor];
        [grayView addSubview:lineView3];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineView3.right, 10, 40, 16)];
        textLabel.text =@"推广";
        textLabel.textColor = [UIColor grayColor];
        textLabel.font =[UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [grayView addSubview:textLabel];
        
        UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(textLabel.right, grayView.height/2-1,(lineView.width-40)/2, 1)];
        lineView4.backgroundColor = [UIColor grayColor];
        [grayView addSubview:lineView4];
        
        
    }
    
    
    
    UIView *adverView = [[UIView alloc]initWithFrame:self.layout.advertiseFrame];
    adverView.backgroundColor = [UIColor whiteColor];
    
    [scroll addSubview:adverView];
    
    //加载广告200高度
    
    
    Advertise *adv=[Advertise sharedInstance];
    NSInteger adv_number = arc4random()%(adv.advArray.count);
    NSDictionary *adv_dic = adv.advArray[adv_number];
    
    UIImageView *advImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, adverView.width, adverView.height-30)];
    [advImageView sd_setImageWithURL:[NSURL URLWithString:adv_dic[@"image_url"]]];
    [adverView addSubview:advImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, advImageView.bottom, adverView.width-5, adverView.height-advImageView.height)];
    textLabel.text = adv_dic[@"stitle"];
    [adverView addSubview:textLabel];
    
    
    
    
    
    
}

//计算文本宽度
- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
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


- (NSInteger)compared:(NSInteger)a and:(NSInteger)b{
    if (a>b) {
        return b;
    }
    else{
        return a;
    }
    
}

//海边图片的分辨率
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
