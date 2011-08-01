//
//  CardBackground.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardBackground.h"

@implementation CardBackground

+ (UIImage *)normal:(CGSize) size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, size.width * 0.05);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);

    CGFloat radius = size.width * 0.10;
    CGFloat minx = size.width * 0.05, maxx = size.width * 0.95;
    CGFloat miny = size.height * 0.05, maxy = size.height * 0.95;

    CGContextBeginPath (context);
    CGContextMoveToPoint(context, minx, miny + radius);
    CGContextAddArcToPoint(context, minx, miny, minx + radius, miny, radius);
    CGContextAddLineToPoint(context, maxx - radius, miny);
    CGContextAddArcToPoint(context, maxx, miny, maxx, miny + radius, radius);
    CGContextAddLineToPoint(context, maxx, maxy - radius);
    CGContextAddArcToPoint(context, maxx, maxy, maxx - radius, maxy, radius);
    CGContextAddLineToPoint(context, minx + radius, maxy);
    CGContextAddArcToPoint(context, minx, maxy, minx, maxy - radius, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextBeginPath (context);
    CGContextMoveToPoint(context, minx, miny + radius);
    CGContextAddArcToPoint(context, minx, miny, minx + radius, miny, radius);
    CGContextAddLineToPoint(context, maxx - radius, miny);
    CGContextAddArcToPoint(context, maxx, miny, maxx, miny + radius, radius);
    CGContextAddLineToPoint(context, maxx, maxy - radius);
    CGContextAddArcToPoint(context, maxx, maxy, maxx - radius, maxy, radius);
    CGContextAddLineToPoint(context, minx + radius, maxy);
    CGContextAddArcToPoint(context, minx, maxy, minx, maxy - radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGGradientRef gradient;    
    CGColorSpaceRef colorspace;    
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
        0.8, 0.8, 0.3, 1.0 }; // End color
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents (colorspace, components,
                                                      locations, num_locations);
    CGContextDrawLinearGradient (context, gradient, CGPointMake(0,0), CGPointMake(0, size.height), 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
