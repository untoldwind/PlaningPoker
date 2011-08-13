//
//  CGHelper.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CGHelper.h"

CGPathRef CGHRoundedRectPath(CGRect rect, CGFloat cornerRadius)
{
    CGPoint points[] = {
        rect.origin,
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height),
        CGPointMake(rect.origin.x, rect.origin.y + rect.size.height)
    };
    CGFloat radii[] = {
        cornerRadius,
        cornerRadius,
        cornerRadius,
        cornerRadius
    };
    
    return CGHRoundedPolygon(4, points, radii);
}

CGPathRef CGHRoundedRectPathWithCutEdge(CGRect rect, CGFloat cornerRadius, CGFloat cutX, CGFloat cutY)
{
    CGPoint p0 = CGPointMake(rect.origin.x, rect.origin.y + cutY);
    CGPoint p1 = CGPointMake(rect.origin.x + cutX, rect.origin.y);
    CGFloat cutDistance = CGHDistance(p0, p1);
    CGPoint points[] = {
        p0,
        p1,
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height),
        CGPointMake(rect.origin.x, rect.origin.y + rect.size.height)
    };
    CGFloat radii[] = {
        cutDistance / 10.0,
        cutDistance / 10.0,
        cornerRadius,
        cornerRadius,
        cornerRadius
    };
    
    return CGHRoundedPolygon(5, points, radii);
}

CGPathRef CGHTriangle(CGPoint p1, CGPoint p2, CGPoint p3) 
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    
    CGPathCloseSubpath(path);
    
    return path;
}

CGPathRef CGHPolygon(int count, CGPoint points[])
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    for ( int i = 0; i < count; i++ ) {
        if ( i == 0 )
            CGPathMoveToPoint(path, NULL, points[i].x, points[i].y);
        else
            CGPathAddLineToPoint(path, NULL, points[i].x, points[i].y);
    }
    
    CGPathCloseSubpath(path);
    
    return path;    
}
CGPathRef CGHRoundedPolygon(int count, CGPoint points[], CGFloat radii[])
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    for ( int i = 0; i < count; i++ ) {
        CGPoint p0 = points[(i + count - 1) % count];
        CGPoint p1 = points[i];
        CGPoint p2 = points[(i + 1) % count];
        CGFloat prevLen = CGHDistance(p0, p1);
        CGFloat nextLen = CGHDistance(p2, p1);
        p0 = CGHMidPoint(p1, p0, radii[i] / prevLen);
        p2 = CGHMidPoint(p1, p2, radii[i] / nextLen);
            
        if ( i == 0 )
            CGPathMoveToPoint(path, NULL, p0.x, p0.y);
        else
            CGPathAddLineToPoint(path, NULL, p0.x, p0.y);
        CGPathAddQuadCurveToPoint(path, NULL, p1.x, p1.y, p2.x, p2.y);
    }
    
    CGPathCloseSubpath(path);
    
    return path;    
}

CGFloat CGHDistance(CGPoint p1, CGPoint p2) 
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

CGPoint CGHMidPoint(CGPoint p1, CGPoint p2, CGFloat mid)
{
    return CGPointMake((p2.x - p1.x) * mid + p1.x, (p2.y - p1.y) * mid + p1.y);
}