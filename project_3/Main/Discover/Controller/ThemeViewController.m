//
//  ThemeViewController.m
//  project_3
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ThemeViewController.h"

#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"
#import "Common.h"
#import "waterfallLayout.h"
#import "CellModel.h"
#import "DataService.h"
#import "WXRefresh.h"
#import "DetailsViewController.h"


static NSString* const WaterfallCellIdentifier = @"WaterfallCell_2";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader_2";
@interface ThemeViewController ()<FRGWaterfallCollectionViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView *alphaView;
    UILabel *themeLabel;
    UIButton *back_button;
    
    NSString *star;
    
    //头视图
    FRGWaterfallHeaderReusableView *titleView;
}

@property (nonatomic, strong) NSMutableArray *cellHeights;
//专门放waterfallLayout，这里需要懒加载下
@property (nonatomic, copy)NSMutableArray *layoutList;
//存放抓取的数组
@property(nonatomic,copy) NSArray *dataArray;

@property(nonatomic,copy)NSMutableArray *buttonNames;

//头视图高度
@property(nonatomic,assign)CGFloat headerViewHeight;



@end


@implementation ThemeViewController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray =[NSArray array ];
    }
    return _dataArray;
    
    
}

- (NSMutableArray *)layoutList {
    if (_layoutList ==nil) {
        _layoutList = [NSMutableArray array];
    }
    return _layoutList;
}
//单元格高度数组（随机的） 懒加载
- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:900];
        for (NSInteger i = 0; i < 900; i++) {
            _cellHeights[i] = @(arc4random()%100*2+100);
        }
    }
    return _cellHeights;
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha=1;
    back_button.hidden=YES;
    alphaView.hidden=YES;
    themeLabel.hidden=YES;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    UIImageView   *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    back_button.hidden=NO;
    alphaView.hidden=NO;
    themeLabel.hidden=NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
    UIImageView   *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.navigationController.navigationBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
//     self.navigationController.navigationBar.alpha=0.1;
    
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:255/255.0 alpha:1];
    
    star = @"0";
    [self _setBackBarButton];
    
    
    
    self.Cv.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0.4];
    
    [self requestData];
    
    
//    [self.Cv addInfiniteScrollingWithActionHandler:^{
//        [self requestData];
//       [self.Cv.infiniteScrollingView stopAnimating];
//    }];
    
    _buttonNames = [[NSMutableArray alloc] init];
    [DataService getCategaryRequestWithNextStart:self.condition Success:^(NSArray *result, NSString *start) {
        
        for (NSDictionary *dic in result) {
            
            NSString *name = dic[@"name"];
            [_buttonNames addObject:name];
            
            
        }

        
        
        
        
        
        [self.Cv reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    self.Cv.delegate = self;
    self.Cv.dataSource =self;
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    
    
    cvLayout.itemWidth = (kScreenWidth-40)/2;
    cvLayout.topInset = 10.0f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = NO;
    
    [self.Cv setCollectionViewLayout:cvLayout];
   // [self.Cv reloadData];
    
}



- (void)requestData{
    //界面以显示就请求数据.请求的数据放到数组里面，然后cell加载的时候，一个一个根据indexpath.row传递给cell.
    //把参数传递进去
    [DataService getThemeCellRequestWithNextStart:self.condition andStar: star Success:^(NSArray *result, NSString *start) {
        
        star =start;
        self.dataArray =result;
        for (NSDictionary *dic in _dataArray) {
            
            
            waterfallLayout *layout =[[waterfallLayout alloc] init];
            CellModel *model = [[CellModel alloc] init];
            
            //0.主图
            NSDictionary *photo = dic[@"photo"];
            NSString *path = photo[@"path"];
            //格式不对，拼接下;http://img3.duitang.com/uploads/item/201608/13/20160813231425_2cY4h.jpeg_webp
            NSRange range = NSMakeRange(0, path.length-5);
            path = [path substringWithRange:range];
            model.path =path;
            //高度与宽度
            
            model.imgWidth  = [photo[@"width"] integerValue];
            model.imgHeight = [photo[@"height"] integerValue];
            
            
            
            
            //1.用户头像图片地址
            NSDictionary *sender = dic[@"sender"];
            NSString *avatarPath = sender[@"avatar"];
            model.avatar =avatarPath;
            
            //2.图片描述
            model.msg = dic[@"msg"];
            
            //3.别名
            NSDictionary *album = dic[@"album"];
            NSString *name = album[@"name"];
            model.name =name;
            
            //4.用户名字
            NSString *username = sender[@"username"];
            model.username =username;
            
            //5.重复次数
            model.reply_count = [dic[@"reply_count"] integerValue];
            model.like_count = [dic[@"like_count"] integerValue];
            model.favorite_count = [dic[@"favorite_count"] integerValue];
            model.numberID =dic[@"id"];
            //商品类
            
            if (dic[@"item"] != nil) {
                
                NSDictionary *item =dic[@"item"];
                model.price = [NSString stringWithFormat:@"%@",item[@"price"]];
                //固定的购物车图标
                model.icon_url =@"http://img4.duitang.com/uploads/files/201408/29/20140829123010_Psd4P.png";
                model.buyable =YES;
                
            }
            //循环结束
            else {
                model.price=@"0.0";
                model.buyable =NO;
                model.icon_url =nil;
            }
            layout.cellModel = model;
            [self.layoutList addObject:layout];
            
        }
        
        [self.Cv reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"请求搜索数据失败");
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self.Cv collectionViewLayout] invalidateLayout];
}

#pragma mark - UICollectionViewDataSource
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组单元格数
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _layoutList.count;
}

#pragma mark 自定义单元格
//加载单元格,宽度140 ，高度自适应
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    //这里把请求的数据传递给cell.layout
    
    waterfallCell.layout = self.layoutList[indexPath.row];
    return waterfallCell;
}
//单元格高度

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    waterfallLayout *layout = _layoutList[indexPath.row];
    return layout.cellHeight;
}
//头视图高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    CGFloat lenght = 10;
    CGFloat row = 0;
    
    for (NSInteger i =0; i<_buttonNames.count ; i++) {
        
        NSString *name= _buttonNames[i];
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
    CGFloat headerViewHeight = 64+10+(30+10)*(row+1)+40;

    self.headerViewHeight =headerViewHeight;
    return headerViewHeight;
}


//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath; {
    titleView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:@"WaterfallHeader_2"
                                              forIndexPath:indexPath];
    titleView.frame = CGRectMake(0, 0, kScreenWidth,self.headerViewHeight);
    waterfallLayout *layout = self.layoutList[0];
    titleView.image_url = layout.cellModel.path;
    titleView.butonNames =self.buttonNames;
    titleView.height = self.headerViewHeight;
    [titleView buttonStyle];
    return titleView;
    
}


#pragma mark 点击单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    waterfallLayout *lay = self.layoutList[indexPath.row];
    
    
    DetailsViewController *details = [[DetailsViewController alloc] init];
    //传递请求参数.
    details.numberID =lay.cellModel.numberID;
  
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:details animated:YES];
}

- (void)_setBackBarButton{
    
    
    themeLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    self.navigationItem.titleView =themeLabel;
    themeLabel.backgroundColor = [UIColor clearColor];
    themeLabel.text = self.theme;
    themeLabel.textColor = [UIColor whiteColor];
    
    
    //隐藏自带的
    self.navigationItem.hidesBackButton =YES;
    
    
    //自定义左侧按钮
    back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    back_button.frame =CGRectMake(0, 0, 30, 30);
    // button.frame =CGRectMake(10, 20+((64-20)-30)/2, 30, 30);
    [back_button setImage:[UIImage imageNamed:@"icon_back_light@2x.png"] forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(backToController) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.navigationController.navigationBar addSubview:button];
//    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back_button];
    self.navigationItem.leftBarButtonItem =backButton;
    
    
    
    
    CGRect frame = self.navigationController. navigationBar.frame;
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
    alphaView.backgroundColor = [UIColor whiteColor];
    alphaView.alpha=0.02;
    [self.view insertSubview:alphaView belowSubview:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    
    
    
    
    
}

- (void)backToController {
    [self.navigationController popViewControllerAnimated:YES];
}




//计算文本宽度

- (CGSize )getLabelRectFromString:(NSString *)string andFont:(NSInteger)ftn {
    
    CGRect tempRect = [string   boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ftn]}context:nil];
    
    return CGSizeMake(tempRect.size.width, tempRect.size.height);
    
}




#pragma mark scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY =scrollView.contentOffset.y;
    
    if (offsetY ==-64) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage  imageNamed:@"bigShadow.png"]forBarMetrics:UIBarMetricsCompact];
        self.navigationController.navigationBar.shadowImage = [UIImage  imageNamed:@"bigShadow.png"];
        
        
    }
    if (offsetY >-20) {
        
        [back_button setImage:[UIImage imageNamed:@"icon_back_dark@2x.png"] forState:UIControlStateNormal];
        themeLabel.textColor= [UIColor
                               blackColor];
        
        
       
        
    }
    else{
        
        [back_button setImage:[UIImage imageNamed:@"icon_back_light@2x.png"] forState:UIControlStateNormal];
        themeLabel.textColor= [UIColor
                              whiteColor];
        
    }
    
    
    CGFloat rage = 64 +offsetY;
    CGFloat rages = rage/64;
    if (rages >1) {
        rages =1;
    }
    
    
    if (rages <0) {
        rages =0;
    }
    alphaView.alpha = rages;
    
    
    
    
    if(offsetY <-64){

        
        titleView.top = (offsetY +64);
    

    }
    

    
    if(self.Cv.height+offsetY>self.Cv.contentSize.height+20){
        
        [self requestData];
        
        
        
        
    }
    
    
}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


@end
