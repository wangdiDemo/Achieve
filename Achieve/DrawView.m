//
//  DrawView.m
//  Achieve
//
//  Created by lingxi on 14-2-27.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import "DrawView.h"
#include "Line.h"

@implementation DrawView
Line *line;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //初始化 画线的 颜色 和 宽度
        self.lines = [NSMutableArray array];
        self.currentColor = [UIColor orangeColor];
        self.currentWidth = 5;
    }
    
    return self;
}

#pragma mark
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began!");
    
    UITouch * touch = [touches anyObject];
    CGPoint  p = [touch locationInView:self];
    
    line = [[Line alloc]init];
    line.color = _currentColor;
    line.width = _currentWidth;
    line.points = [NSMutableArray array]; //在非ARC里面 等于添加勒一个autorelease
    [line.points addObject:[NSValue valueWithCGPoint:p]];
    
    [self.lines addObject:line];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"move!");
    
    UITouch * touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    [line.points addObject:[NSValue valueWithCGPoint:p]];
    
    [self setNeedsDisplay]; //等于手动执行一边 drawRect方法
}
#pragma mark Draw
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (Line * line in self.lines) {
        //设置颜色和宽度
        CGContextSetStrokeColorWithColor(context, line.color.CGColor);
        CGContextSetLineWidth(context, line.width);
        
        for (int i = 0; i<line.points.count; i++) {
            CGPoint p = [[line.points objectAtIndex:i] CGPointValue];
            
            //如果是第一个 就移动到当前位置
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
            }else{
                CGContextAddLineToPoint(context, p.x, p.y);
            }
        }
        CGContextDrawPath(context, kCGPathStroke);
    }
    [super drawRect:rect];
}
#pragma mark clickButton

 
@end
