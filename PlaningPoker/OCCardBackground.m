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

    CGRect rect = CGRectMake(size.width * 0.05, size.height * 0.05, size.width * 0.9, size.height * 0.9 );
    
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

    CGContextSetLineWidth(context, size.width * 0.03);
    CGContextSetRGBStrokeColor(context, 0.0, 165.0 / 255.0, 222.0 / 255.0, 1.0);
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
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
        
    CGRect rect = CGRectMake(size.width * 0.05, size.height * 0.05, size.width * 0.9, size.height * 0.9 );
    
    CGPathRef path = CGHRoundedRectPath(rect, size.width * 0.10);

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
