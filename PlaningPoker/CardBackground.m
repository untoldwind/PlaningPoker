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

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, minx, miny + radius);
    CGPathAddArcToPoint(path, NULL, minx, miny, minx + radius, miny, radius);
    CGPathAddLineToPoint(path, NULL, maxx - radius, miny);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, miny + radius, radius);
    CGPathAddLineToPoint(path, NULL, maxx, maxy - radius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, maxx - radius, maxy, radius);
    CGPathAddLineToPoint(path, NULL, minx + radius, maxy);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, maxy - radius, radius);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);

    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGPathRelease(path);
    
    CGGradientRef gradient;    
    CGColorSpaceRef colorspace;    
    size_t num_locations = 3;
    CGFloat locations[3] = { 0.0, 0.5, 1.0 };
    CGFloat components[12] = {
        0.8, 0.4, 0.1, 1.0,
        0.9, 0.5, 0.2, 1.0,
        0.8, 0.4, 0.1, 1.0 };
    
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

+ (UIImage *)hidden:(CGSize) size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, size.width * 0.05);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGFloat radius = size.width * 0.10;
    CGFloat minx = size.width * 0.05, maxx = size.width * 0.95;
    CGFloat miny = size.height * 0.05, maxy = size.height * 0.95;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, minx, miny + radius);
    CGPathAddArcToPoint(path, NULL, minx, miny, minx + radius, miny, radius);
    CGPathAddLineToPoint(path, NULL, maxx - radius, miny);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, miny + radius, radius);
    CGPathAddLineToPoint(path, NULL, maxx, maxy - radius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, maxx - radius, maxy, radius);
    CGPathAddLineToPoint(path, NULL, minx + radius, maxy);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, maxy - radius, radius);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGGradientRef gradient;    
    CGColorSpaceRef colorspace;    
    size_t num_locations = 3;
    CGFloat locations[3] = { 0.0, 0.5, 1.0 };
    CGFloat components[12] = {
        0.8, 0.4, 0.1, 1.0,
        0.9, 0.5, 0.2, 1.0,
        0.8, 0.4, 0.1, 1.0 };
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents (colorspace, components,
                                                    locations, num_locations);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width * 0.5, size.height * 0.5), 0, 
                                CGPointMake(size.width * 0.5, size.height * 0.5), 0.8 * size.width, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextSetLineWidth(context, size.width * 0.03);
    CGContextTranslateCTM(context, 0.1 * size.width, 0.1 * size.height);
    CGContextScaleCTM(context, 0.8, 0.8);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);

    CGContextTranslateCTM(context, 0.15 * size.width, 0.15 * size.height);
    CGContextScaleCTM(context, 0.7, 0.7);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextTranslateCTM(context, 0.2 * size.width, 0.2 * size.height);
    CGContextScaleCTM(context, 0.6, 0.6);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;    
}

@end
