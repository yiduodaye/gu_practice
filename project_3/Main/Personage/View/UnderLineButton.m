//
//  UnderLineButton.m
//  project_3
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UnderLineButton.h"
#import "Common.h"
@implementation UnderLineButton


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext()  ;
    UIBezierPath *path =[UIBezierPath bezierPath];
    CGPoint starPoint =CGPointMake(4, self.height-2);
    CGPoint endPoint =CGPointMake(self.width-4,self.height-2);
    [path moveToPoint:starPoint];
    [path addLineToPoint:endPoint];
    UIColor *strokeColor = [UIColor whiteColor];
    CGContextSetLineWidth(context, 1);
    [strokeColor setStroke];
    
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);

}

@end
