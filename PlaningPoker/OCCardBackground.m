//
//  OCCardBackground.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "OCCardBackground.h"

#import "CGHelper.h"

@implementation OCCardBackground

@synthesize name = _name;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;

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
        _shadowColor = [[UIColor lightGrayColor] retain];
        _cache = [[NSMutableDictionary dictionary] retain];
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
    return YES;
}

-(UIImage *)normal:(CGSize)size
{
    NSString *key = [NSString stringWithFormat:@"normal_%f:%f", size.width, size.height];
    UIImage *normal = [_cache objectForKey:key];
    
    if ( normal != nil )
        return normal;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGRect rect = CGRectMake(size.width * 0.01, size.height * 0.01, size.width * 0.98, size.height * 0.98 );
    
    CGPathRef path = CGHRoundedRectPath(rect, size.width * 0.10);

    CGContextAddPath(context, path);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);    
    CGContextFillPath(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    rect = CGRectMake(rect.origin.x + size.width * 0.06,
                      rect.origin.y + size.width * 0.06,
                      rect.size.width - size.width * 0.12,
                      rect.size.height - size.width * 0.12);
    
    path = CGHRoundedRectPath(rect, size.width * 0.08);
    CGContextSetLineWidth(context, size.width * 0.05);
    CGContextSetRGBStrokeColor(context, 0.0, 165.0 / 255.0, 222.0 / 255.0, 1.0);    
    CGContextSetRGBFillColor(context, 0.0, 165.0 / 255.0, 222.0 / 255.0, 1.0);    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);

    rect = CGRectMake(rect.origin.x + size.width * 0.04,
                      rect.origin.y + size.width * 0.18,
                      rect.size.width - size.width * 0.08,
                      rect.size.height - size.width * 0.22);
    
    path = CGHRoundedRectPathWithCutEdge(rect, size.width * 0.05, size.width * 0.3, size.width * 0.2);
    CGContextSetLineWidth(context, size.width * 0.01);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    
    CGPoint points[] = {
        CGPointMake(rect.origin.x, rect.origin.y - size.width * 0.14),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y - size.width * 0.14),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y - size.width * 0.03),
        CGPointMake(rect.origin.x + size.width * 0.29, rect.origin.y - size.width * 0.03),
        CGPointMake(rect.origin.x, rect.origin.y + size.width * 0.16),
    };
    CGFloat radii[] = {
        size.width * 0.03,
        size.width * 0.03,
        0.0,
        size.width * 0.03,
        0.0
    };
    path = CGHRoundedPolygon(5, points, radii);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
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
        
    CGRect rect = CGRectMake(size.width * 0.01, size.height * 0.01, size.width * 0.98, size.height * 0.98 );
    
    CGPathRef path = CGHRoundedRectPath(rect, size.width * 0.10);
    
    CGContextAddPath(context, path);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);    
    CGContextFillPath(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    rect = CGRectMake(rect.origin.x + size.width * 0.04,
                      rect.origin.y + size.width * 0.04,
                      rect.size.width - size.width * 0.08,
                      rect.size.height - size.width * 0.08);
    
    path = CGHRoundedRectPath(rect, size.width * 0.08);
    
    CGContextSetLineWidth(context, size.width * 0.01);
    CGContextSetRGBStrokeColor(context, 0.0, 165.0 / 255.0, 222.0 / 255.0, 1.0);
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    UIImage *ocLogo = [UIImage imageNamed:@"oc-act-logo-large.png"];
    UIImage *ocLogoDown = [UIImage imageWithCGImage:ocLogo.CGImage scale:1.0 orientation:UIImageOrientationDown];
    CGSize targetSize = CGSizeMake(size.width * 0.7, ocLogo.size.height * size.width * 0.7 / ocLogo.size.width);
    
    [ocLogoDown drawInRect:CGRectMake(size.width * 0.15, size.height * 0.55, targetSize.width, targetSize.height)];    
    [ocLogo drawInRect:CGRectMake(size.width * 0.15, size.height * 0.45 - targetSize.height, targetSize.width, targetSize.height)];
    
    hidden = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:hidden forKey:key];
    
    UIGraphicsEndImageContext();
    
    return hidden;
}

@end
