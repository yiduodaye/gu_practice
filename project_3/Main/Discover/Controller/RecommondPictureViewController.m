//
//  RecommondPictureViewController.m
//  project_3
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommondPictureViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"
#import "Common.h"
#import "waterfallLayout.h"
#import "CellModel.h"
#import "DataService.h"
#import "DetailsViewController.h"
#import "Advertise.h"
#import "WXRefresh.h"


static NSString* const WaterfallCellIdentifier = @"WaterfallCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";


@interface RecommondPictureViewController ()<FRGWaterfallCollectionViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString *star;
}

@property (nonatomic, strong) NSMutableArray *cellHeights;
//专门放waterfallLayout，这里需要懒加载下
@property (nonatomic, copy)NSMutableArray *layoutList;
//存放抓取的数组
@property(nonatomic,copy) NSArray *dataArray;

@end

@implementation RecommondPictureViewController



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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    star =@"0";
    self.Cv.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0.2];
    
    self.navigationItem.title =@"热门图片";
    [self _setBackBarButton];
    
    self.Cv.delegate = self;
    self.Cv.dataSource =self;
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    
    
    cvLayout.itemWidth = (kScreenWidth-40)/2;
    cvLayout.topInset = 10.f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = NO;
    
       [self.Cv addInfiniteScrollingWithActionHandler:^{
           [self requestData];
           [self.Cv.infiniteScrollingView stopAnimating];
           
       }];
    [self.Cv setCollectionViewLayout:cvLayout];
    [self.Cv reloadData];

    [self requestData];
}

- (void)requestData{
    //界面以显示就请求数据.请求的数据放到数组里面，然后cell加载的时候，一个一个根据indexpath.row传递给cell.
    
    [DataService getHotPicRequestWithNextStart:star Success:^(NSArray *result, NSString *start) {
        NSLog(@"请求热门图片数据成功");
        self.dataArray =result;
        star = start;
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
            
            //id
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
        
        //        waterfallLayout *lay= self.layoutList[0];
        //        NSLog(@"几级:%@", lay.cellModel.name);
        //        NSLog(@"jid:%@",lay.cellModel.numberID);
        if(self.layoutList.count!=0){
            
        [self.Cv reloadData];
        }
       // [self.Cv.pullToRefreshView stopAnimating];
    
        
    } failure:^(NSError *error) {
        NSLog(@"请求热门图片数据失败");
    }];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self.Cv collectionViewLayout] invalidateLayout];
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

- (void)backToController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组单元格数
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.layoutList.count;
}

#pragma mark 自定义单元格
//加载单元格,宽度140 ，高度自适应
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    //这里把请求的数据传递给cell.layout
    //这点也蹦亏，应该是拉住不放就崩溃了
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
    return 100;
}


//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath; {
    FRGWaterfallHeaderReusableView *titleView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:@"WaterfallHeader"
                                              forIndexPath:indexPath];
    
    titleView.frame = CGRectMake(0, 10, kScreenWidth+4, 100);
    [titleView defaultStyle];
    return titleView;

}
#pragma  mark 点击单元格

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    //通过model的numberID传递
    
    waterfallLayout *lay = self.layoutList[indexPath.row];

    
    DetailsViewController *details = [[DetailsViewController alloc] init];
    //传递请求参数.
    details.numberID =lay.cellModel.numberID;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:details animated:YES];
    
    
    
    
    
}
#pragma  mark 下拉滑动刷新
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat offsetY= scrollView.contentOffset.y;
   
    if (offsetY <-64) {
         [self.layoutList removeAllObjects];
        
        
     
        
        [self requestData];
        
      
    }

   
}



@end
