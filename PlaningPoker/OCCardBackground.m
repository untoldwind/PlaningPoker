//
//  OCCardBackground.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "OCCardBackground.h"

@implementation OCCardBackground

@synthesize name = _name;
@synthesize textColor = _textColor;

+ (OCCardBackground *)withName:(NSString *)name
{
    return [[[OCCardBackground alloc] initWithName:name] autorelease];
}

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name retain];
        _textColor = [[UIColor blackColor] retain];
        _cache = [[NSMutableDictionary dictionary] retain];
    }
    
    return self;
}

-(void)dealloc
{
    [_name release];
    [_textColor release];
    [_cache release];
    [super dealloc];
}

-(UIImage *)normal:(CGSize)size
{
    NSString *key = [NSString stringWithFormat:@"normal_%f:%f", size.width, size.height];
    UIImage *normal = [_cache objectForKey:key];
    
    if ( normal != nil )
        return normal;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();

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
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);    
    CGContextFillPath(context);

    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGPathRelease(path);
        
    normal = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:normal forKey:key];
    
    UIGraphicsEndImageContext();
    
    return normal;
}

-(UIImage *)hidden:(CGSize)size
{
    NSString *key = [NSString stringWithFormat:@"hidden_%f:%f", size.width, size.height];
    UIImage *hidden = [_cache objectForKey:key];
    
    if ( hidden != nil )
        return hidden;

    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
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
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);    
    CGContextFillPath(context);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGPathRelease(path);
    
    hidden = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:hidden forKey:key];
    
    UIGraphicsEndImageContext();
    
    return hidden;
}

@end
