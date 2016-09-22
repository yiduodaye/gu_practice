//
//  HotPeopleTableView.m
//  project_3
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotPeopleTableView.h"
#import "PersonageHeaderView.h"
#import "HotPeopleTableViewCell.h"
#import "Common.h"
#import "DataService.h"
#import "HotPeopleCellModel.h"
#import "HotPeopleLayout.h"



@interface HotPeopleTableView ()

@property (nonatomic,copy)NSArray *data;
@property (nonatomic, copy)NSMutableArray *layoutList;

@end


@implementation HotPeopleTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    
    if (self) {
      
       self.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
        self.delegate=self;
        self.dataSource=self;
        [self requestData];
        self.separatorColor =UITableViewCellSeparatorStyleNone;
        [self setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
        
    }
    return self;
}

- (NSMutableArray *)layoutList {
    if (_layoutList == nil) {
        _layoutList = [NSMutableArray array];
    }
    return _layoutList;
}

- (NSArray *)dataDic {
    if (_data == nil) {
        _data = [NSArray array];
    }
    return _data;
}


- (void)requestData {
    
    [DataService getHotPeopleRequestSuccess:^(NSArray *result, NSString *start) {
        //抓取初始的数据
        self.data = result;
        
        
        //layoutlist放9个数组，每个数组里面全是layout;
        for (NSDictionary *dic in result) {
            
            NSArray *items = dic[@"items"];
            NSInteger count = items.count;
            NSMutableArray *arr_1 = [[NSMutableArray alloc] initWithCapacity:count];
            //创建了一定容量的数组，存放layout；
            
            for (NSDictionary *allDic in items) {
                
                HotPeopleCellModel *model =[[HotPeopleCellModel alloc] init];
                //名字;
                model.username = allDic[@"username"];
                
                //头像url
                model.avatar = allDic[@"avatar"];
                
                //是否关注
                model.relationship = [allDic[@"relationship"] integerValue];
                
                //链接
                model.target =allDic[@"target"];
                
                //简介
                model.short_description = allDic[@"short_description" ];
                
                //daren_tags数组
                model.daren_tags  =allDic[@"daren_tags"];
                model.daren_identity=allDic[@"daren_identity"];
                //这个一般为空，暂时接收的数据里面这个值都为空
                model.daren_type = allDic[@"daren_type"];
                model.daren_description = allDic[@"daren_description"];
                
                /*在循环链model值已经赋好，循环一次创建好一个layout*/
                
                HotPeopleLayout *layout = [[HotPeopleLayout alloc ] init];
                layout.model =model;
                [arr_1 addObject:layout];
                
            }
            //5次完毕，arr_1创建好.
            /*在循环链model值已经赋好*/
            
            [self.layoutList addObject:arr_1];
            
        }
        
        
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
    

}

#pragma mark delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    //通过抓取的数据的个数来决定
    return self.data.count;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dic = self.data[section];
    NSArray *array = dic[@"items"];
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotPeopleTableViewCell *cell = [[HotPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotCell"];
   
    NSArray *array = self.layoutList[indexPath.section];
    
    
    
    cell.layout = array [indexPath.row];
    
    if (array.count == indexPath.row) {
        cell.grayView.hidden =YES;
    }
    [cell.attent addTarget:self action:@selector(attent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    PersonageHeaderView *header = [[PersonageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    header.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    NSDictionary *dic = self.data[section];
    header.title.text = dic[@"name"];
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.layoutList[indexPath.section];
    
     HotPeopleLayout *layout = array[indexPath.row];
    
    return layout.cellHeight;
    
}


- (void)attent:(UIButton *)button {
    
    button.selected = !button.selected;
    
    if (button.selected) {
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor colorWithRed:94/255.0 green:190/255.0 blue:50/255.0 alpha:1].CGColor;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 1;
        [button setTitleColor:[UIColor colorWithRed:94/255.0 green:190/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitle:@"已关注" forState:UIControlStateNormal];
    }
    else {
        button.layer.cornerRadius =5;
        button.backgroundColor = [UIColor colorWithRed:94/255.0 green:190/255.0 blue:50/255.0 alpha:1];
        button.layer.borderWidth = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"关注" forState:UIControlStateNormal];
    }
}

@end
