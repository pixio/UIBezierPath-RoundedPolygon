//
//  UIBezierPath+RoundedPolygon.m
//  PixioAdditions
//
//  Created by Daniel Blakemore on 11/19/13.
//
//  Copyright (c) 2015 Pixio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIBezierPath+RoundedPolygon.h"

@implementation UIBezierPath (RoundedPolygon)

- (void) addPointsAsRoundedPolygon:(NSArray*)points withCornerRadius:(CGFloat)cornerRadius
{
    [self setLineCapStyle:kCGLineCapRound];
    
    [self setUsesEvenOddFillRule:TRUE];
    
    void (^addPoints)(CGPoint, CGPoint, CGPoint) = ^(CGPoint prev, CGPoint curr, CGPoint next) {
        // get prev <- curr
        CGPoint c2p = CGPointMake(prev.x - curr.x, prev.y - curr.y);
        
        // next <- curr (diagrams with straws [name that reference, future programmer!])
        CGPoint c2n = CGPointMake(next.x - curr.x, next.y - curr.y);
        
        // normalize
        CGFloat magP = sqrtf(c2p.x * c2p.x + c2p.y * c2p.y);
        CGFloat magN = sqrtf(c2n.x * c2n.x + c2n.y * c2n.y);
        
        c2p.x /= magP;
        c2p.y /= magP;
        c2n.x /= magN;
        c2n.y /= magN;
        // shweet
        
        // angles
        CGFloat omega = acosf(c2n.x * c2p.x + c2n.y * c2p.y);
        CGFloat theta = M_PI_2 - (omega / 2);
        
        CGFloat adjustifiedCornerRadius = cornerRadius / theta * M_PI_4;
        
        // r sin(THETA)
        CGFloat rSinTheta = adjustifiedCornerRadius * tanf(theta);
        CGPoint startPoint;
        startPoint.x = curr.x + rSinTheta * c2p.x;
        startPoint.y = curr.y + rSinTheta * c2p.y;
        CGPoint endPoint;
        endPoint.x = curr.x + rSinTheta * c2n.x;
        endPoint.y = curr.y + rSinTheta * c2n.y;
        
        // go perpendicular from start point by corner radius
        CGPoint centerPoint;
        centerPoint.x = startPoint.x + c2p.y * adjustifiedCornerRadius;
        centerPoint.y = startPoint.y - c2p.x * adjustifiedCornerRadius;
        
        CGFloat startAngle = atan2f(c2p.x, -c2p.y);
        CGFloat endAngle = startAngle + (2 * theta);
        
        [self addLineToPoint:startPoint];
        [self addArcWithCenter:centerPoint radius:adjustifiedCornerRadius startAngle:startAngle endAngle:endAngle clockwise:TRUE];
        
        // rinse and repeat
    };
    
    // Set the starting point of the shape.
    int len = (int)[points count];
    CGPoint prev = [points[len - 1] CGPointValue];
    CGPoint curr = [points[0 % len] CGPointValue];
    CGPoint next = [points[1 % len] CGPointValue];
    CGPoint c2p = CGPointMake(prev.x - curr.x, prev.y - curr.y);
    CGPoint c2n = CGPointMake(next.x - curr.x, next.y - curr.y);
    CGFloat magP = sqrtf(c2p.x * c2p.x + c2p.y * c2p.y);
    CGFloat magN = sqrtf(c2n.x * c2n.x + c2n.y * c2n.y);
    c2p.x /= magP;
    c2p.y /= magP;
    c2n.x /= magN;
    c2n.y /= magN;
    CGFloat omega = acosf(c2n.x * c2p.x + c2n.y * c2p.y);
    CGFloat theta = M_PI_2 - (omega / 2);
    CGFloat adjustifiedCornerRadius = cornerRadius / theta * M_PI_4;
    CGFloat rSinTheta = adjustifiedCornerRadius * tanf(theta);
    CGPoint endPoint;
    endPoint.x = curr.x + rSinTheta * c2n.x;
    endPoint.y = curr.y + rSinTheta * c2n.y;
    
    [self moveToPoint:endPoint];
    for (int i = 0; i < len; i++) {
        addPoints([points[i] CGPointValue], [points[(i + 1) % len] CGPointValue], [points[(i + 2) % len] CGPointValue]);
    }
    
    [self closePath];
}

@end
