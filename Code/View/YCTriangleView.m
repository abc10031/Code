//
//  YCTriangleView.m
//  Code
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCTriangleView.h"

@implementation YCTriangleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //线宽
    CGContextSetLineWidth(ctx, 2.0f);
    
    //颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    //可变的路线
    CGMutablePathRef path  = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, rect.size.width / 2, 0);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height - 1);
    CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height - 1 );
    CGPathAddLineToPoint(path, nil, rect.size.width / 2, 0);
    
    CGContextAddPath(ctx, path);
    
    //提交绘图
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //路径释放掉
    CGPathRelease(path);
    
}


@end
