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
    CGMutablePathRef path = CGPathCreateMutable();
   
    CGPathMoveToPoint(path, NULL, 
                      rect.origin.x, 
                      rect.origin.y + cornerRadius);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x, 
                        rect.origin.y, 
                        rect.origin.x + cornerRadius, 
                        rect.origin.y,
                        cornerRadius);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + rect.size.width - cornerRadius,
                         rect.origin.y);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x + rect.size.width, 
                        rect.origin.y, rect.origin.x + rect.size.width,
                        rect.origin.y + cornerRadius, cornerRadius);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + rect.size.width, 
                         rect.origin.y + rect.size.height - cornerRadius);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x + rect.size.width, 
                        rect.origin.y + rect.size.height, 
                        rect.origin.x + rect.size.width - cornerRadius, 
                        rect.origin.y + rect.size.height, 
                        cornerRadius);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + cornerRadius, 
                         rect.origin.y + rect.size.height);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x, 
                        rect.origin.y + rect.size.height, 
                        rect.origin.x, 
                        rect.origin.y + rect.size.height - cornerRadius, 
                        cornerRadius);
    CGPathCloseSubpath(path);

    return path;
}

CGPathRef CGHRoundedRectPathWithCutEdge(CGRect rect, CGFloat cornerRadius, CGFloat cutSize)
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 
                      rect.origin.x, 
                      rect.origin.y + cutSize);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + cutSize, 
                         rect.origin.y);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + rect.size.width - cornerRadius,
                         rect.origin.y);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x + rect.size.width, 
                        rect.origin.y, rect.origin.x + rect.size.width,
                        rect.origin.y + cornerRadius, cornerRadius);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + rect.size.width, 
                         rect.origin.y + rect.size.height - cornerRadius);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x + rect.size.width, 
                        rect.origin.y + rect.size.height, 
                        rect.origin.x + rect.size.width - cornerRadius, 
                        rect.origin.y + rect.size.height, 
                        cornerRadius);
    CGPathAddLineToPoint(path, NULL, 
                         rect.origin.x + cornerRadius, 
                         rect.origin.y + rect.size.height);
    CGPathAddArcToPoint(path, NULL, 
                        rect.origin.x, 
                        rect.origin.y + rect.size.height, 
                        rect.origin.x, 
                        rect.origin.y + rect.size.height - cornerRadius, 
                        cornerRadius);
    CGPathCloseSubpath(path);
    
    return path;
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
