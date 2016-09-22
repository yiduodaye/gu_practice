//
//  InputView.m
//  project_3
//
//  Created by mac on 16/8/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "InputView.h"
#import "Common.h"
@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame ispassword:(BOOL)pwd{
    self =[super initWithFrame:frame];
    if (self) {
        self.pwd = pwd;
        [self _loadSubview];
    }
    return self;
}


-(void)_loadSubview{
    
    self.text = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-15-15-10, self.frame.size.height)];
    self.text.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.text];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(self.text.right-10, 15/2, 25, 25);
    [self.button setImage:[UIImage imageNamed:@"icon_hide@2x.png"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"icon_unhide@2x.png"] forState:UIControlStateSelected];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-10, 1)];
    self.line.backgroundColor = [UIColor colorWithRed:0.906226 green:0.906226 blue:0.906226 alpha:1];
    
    
    
    if (self.pwd) {
        [self addSubview:self.button];
        [self addSubview:self.line];
    }
  
    
    
    
     
    
}


//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    if (self.pwd) {
//        
//        CGContextRef context = UIGraphicsGetCurrentContext()  ;
//        UIBezierPath *path =[UIBezierPath bezierPath];
//        CGPoint starPoint =CGPointMake(0, 1);
//        CGPoint endPoint =CGPointMake(0+self.width,1 );
//        [path moveToPoint:starPoint];
//        [path addLineToPoint:endPoint];
//        UIColor *strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//        CGContextSetLineWidth(context, 0.35);
//        [strokeColor setStroke];
//        
//        CGContextAddPath(context, path.CGPath);
//        CGContextStrokePath(context);
//        
//    }
//
//    
//}

@end
