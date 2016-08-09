//
//  YCDrawView.m
//  Code
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 yaochong. All rights reserved.
//

#import "YCDrawView.h"

@interface YCDrawView ()

/** <#高度#>*/
@property (nonatomic ,assign) CGMutablePathRef drawPath;
@end

@implementation YCDrawView

- (CGMutablePathRef)drawPath {
    
    if (!_drawPath) {
        _drawPath = CGPathCreateMutable();
    }
    return _drawPath;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //第一个点
    UITouch *touch = [touches anyObject];
    
    CGPoint beginPoint = [touch locationInView:self];
    
    CGPathMoveToPoint(self.drawPath, nil, beginPoint.x, beginPoint.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint curPoint = [touch locationInView:self];
    
    CGPathAddLineToPoint(self.drawPath, nil, curPoint.x, curPoint.y);
    
    [self setNeedsDisplay];
}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    CGPathRelease(_drawPath);
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2.0);
    [[UIColor yellowColor] set];
    //画线
//    在其他方法
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //只需添加
    CGContextAddPath(ctx, self.drawPath);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
}


@end
