//
//  FRGHeaderReusableView.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRGWaterfallHeaderReusableView : UICollectionReusableView

@property(nonatomic,copy)NSString *theme;
@property(nonatomic,copy)NSArray *butonNames;
@property(nonatomic,copy)NSString *image_url;
@property(nonatomic,assign)CGFloat height;


@property(nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;


- (void)defaultStyle;
- (void)customStyle;
- (void)buttonStyle;
- (void)imageStyle;

@end
