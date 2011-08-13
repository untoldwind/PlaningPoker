//
//  CardBackground.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "SimpleCardBackground.h"

#import "CGHelper.h"

@implementation SimpleCardBackground

@synthesize name = _name;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;

+ (SimpleCardBackground *)withName:(NSString *)name borderR:(CGFloat)border_r borderG:(CGFloat)border_g borderB:(CGFloat)border_b centerR:(CGFloat)center_r centerG:(CGFloat)center_g centerB:(CGFloat)center_b
{
    return [[[SimpleCardBackground alloc] initWithName:name borderR:border_r borderG:border_g borderB:border_b centerR:center_r centerG:center_g centerB:center_b] autorelease];
}

- (id)initWithName:(NSString *)name borderR:(CGFloat)border_r borderG:(CGFloat)border_g borderB:(CGFloat)border_b centerR:(CGFloat)center_r centerG:(CGFloat)center_g centerB:(CGFloat)center_b
{
    self = [super init];
    if ( self ) {
        _name = [name retain];
        _textColor = [[UIColor whiteColor] retain];
        _shadowColor = [[UIColor darkGrayColor] retain];
        _cache = [[NSMutableDictionary dictionary] retain];
        _border_r = border_r; _border_g = border_g; _border_b = border_b;
        _center_r = center_r; _center_g = center_g; _center_b = center_b;
    }
    return self;
}

-(void)dealloc
{
    [_name release];
    [_textColor release];
    [_shadowColor release];
    [_cache release];
    [super dealloc];
}

- (BOOL)inverted
{
    return NO;
}

- (UIImage *)normal:(CGSize) size cardValue:(NSString *)cardValue
{
    NSString *key = [NSString stringWithFormat:@"normal_%f:%f", size.width, size.height];
    UIImage *normal = [_cache objectForKey:key];
    
    if ( normal != nil )
        return normal;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, size.width * 0.05);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);

    CGRect rect = CGRectMake(size.width * 0.05, size.height * 0.05, size.width * 0.9, size.height * 0.9 );

    CGPathRef path = CGHRoundedRectPath(rect, size.width * 0.10);

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
        _border_r, _border_g, _border_b, 1.0,
        _center_r, _center_g, _center_b, 1.0,
        _border_r, _border_g, _border_b, 1.0, };
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents (colorspace, components,
                                                      locations, num_locations);
    CGContextDrawLinearGradient (context, gradient, CGPointMake(0,0), CGPointMake(0, size.height), 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    normal = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:normal forKey:key];
    
    UIGraphicsEndImageContext();
    
    return normal;
}

- (UIImage *)hidden:(CGSize) size
{
    NSString *key = [NSString stringWithFormat:@"hidden_%f:%f", size.width, size.height];
    UIImage *hidden = [_cache objectForKey:key];
    
    if ( hidden != nil )
        return hidden;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, size.width * 0.05);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        
    CGRect rect = CGRectMake(size.width * 0.05, size.height * 0.05, size.width * 0.9, size.height * 0.9 );
    
    CGPathRef path = CGHRoundedRectPath(rect, size.width * 0.10);

    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGGradientRef gradient;    
    CGColorSpaceRef colorspace;    
    size_t num_locations = 3;
    CGFloat locations[3] = { 0.0, 0.5, 1.0 };
    CGFloat components[12] = {
        _border_r, _border_g, _border_b, 1.0,
        _center_r, _center_g, _center_b, 1.0,
        _border_r, _border_g, _border_b, 1.0, };

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
    
    hidden = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:hidden forKey:key];
    
    UIGraphicsEndImageContext();
    
    return hidden;    
}

@end
