//
//  UserView.m
//  project_3
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserView.h"
#import "Common.h"

@implementation UserView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext()  ;
    UIBezierPath *path =[UIBezierPath bezierPath];
    CGPoint starPoint =CGPointMake(0, 1);
    CGPoint endPoint =CGPointMake(0+self.width,1 );
    [path moveToPoint:starPoint];
    [path addLineToPoint:endPoint];
    UIColor *strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    CGContextSetLineWidth(context, 0.35);
    [strokeColor setStroke];
    
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
    
    
    
}
@end
