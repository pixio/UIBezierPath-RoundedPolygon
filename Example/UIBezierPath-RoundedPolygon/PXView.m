//
//  PXView.m
//  UIBezierPath-RoundedPolygon
//
//  Created by Daniel Blakemore on 10/16/15.
//  Copyright © 2015 Daniel Blakemore. All rights reserved.
//

#import "PXView.h"

#import <UIBezierPath-RoundedPolygon/UIBezierPath+RoundedPolygon.h>

@implementation PXView
{
    UIBezierPath * _polygon;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _polygon = [[UIBezierPath alloc] init];
        [_polygon addPointsAsRoundedPolygon:@[[NSValue valueWithCGPoint:CGPointMake(0, 45)],
                                              [NSValue valueWithCGPoint:CGPointMake(200, 45)],
                                              [NSValue valueWithCGPoint:CGPointMake(100, 219)],
                                              ] withCornerRadius:30];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(ctx, [[UIColor yellowColor] CGColor]);
    
    [_polygon fill];
    [_polygon stroke];
}

@end
