//
//  OCCardBackground.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "OCCardBackground.h"

#import "CGHelper.h"
#import "CardSymbol.h"

@implementation OCCardBackground

@synthesize name = _name;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;

+ (OCCardBackground *)withName:(NSString *)name bgR:(CGFloat)bg_r bgG:(CGFloat)bg_g bgB:(CGFloat)bg_b
{
    return [[[OCCardBackground alloc] initWithName:name bgR:bg_r bgG:bg_g bgB:bg_b] autorelease];
}

- (id)initWithName:(NSString *)name bgR:(CGFloat)bg_r bgG:(CGFloat)bg_g bgB:(CGFloat)bg_b
{
    self = [super init];
    if (self) {
        _name = [name retain];
        _bg_r = bg_r;
        _bg_g = bg_g;
        _bg_b = bg_b;
        _textColor = [[UIColor blackColor] retain];
        _shadowColor = [[UIColor lightGrayColor] retain];
    }
    
    return self;
}

-(void)dealloc
{
    [_name release];
    [_textColor release];
    [_shadowColor release];
    [super dealloc];
}

- (BOOL)inverted
{
    return YES;
}

-(UIImage *)normal:(CGSize)size cardValue:(id)cardValue
{
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
    CGContextSetRGBStrokeColor(context, _bg_r, _bg_g, _bg_b, 1.0);    
    CGContextSetRGBFillColor(context, _bg_r, _bg_g, _bg_b, 1.0);    
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
    
    if ( cardValue != nil ) {
        if ( [cardValue isKindOfClass:[NSString class]] ) {
            UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:size.width * 0.13];
            CGSize fontSize = [cardValue sizeWithFont:font];
            CGContextTranslateCTM(context, rect.origin.x - size.width * 0.01, rect.origin.y + fontSize.width - size.width * 0.13);
            CGContextRotateCTM(context, -M_PI_2);
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0); 
            [cardValue drawAtPoint:CGPointZero withFont:font];
        } else if ( [cardValue isKindOfClass:[CardSymbol class]] ) {
            UIImage *symbol = [cardValue imageWithSize:size.width * 0.13 
                                                 color:[UIColor whiteColor]]; 
            CGContextTranslateCTM(context, rect.origin.x, rect.origin.y - size.width * 0.13);
            [symbol drawAtPoint:CGPointZero];
        }
    }

    UIImage *normal = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return normal;
}

-(UIImage *)hidden:(CGSize)size
{
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
    CGContextSetRGBStrokeColor(context, _bg_r, _bg_g, _bg_b, 1.0);
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    UIImage *ocLogo = [UIImage imageNamed:@"oc-act-logo-large.png"];
    UIImage *ocLogoDown = [UIImage imageWithCGImage:ocLogo.CGImage scale:1.0 orientation:UIImageOrientationDown];
    CGSize targetSize = CGSizeMake(size.width * 0.7, ocLogo.size.height * size.width * 0.7 / ocLogo.size.width);
    
    [ocLogoDown drawInRect:CGRectMake(size.width * 0.15, size.height * 0.55, targetSize.width, targetSize.height)];    
    [ocLogo drawInRect:CGRectMake(size.width * 0.15, size.height * 0.45 - targetSize.height, targetSize.width, targetSize.height)];
    
    UIImage *hidden = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return hidden;
}

@end
