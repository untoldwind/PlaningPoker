//
//  CardSymbol.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 14.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardSymbol.h"

@implementation CardSymbol

+ (CardSymbol *)withNamed:(NSString *)name
{
    return [[[CardSymbol alloc] initWithImage:[UIImage imageNamed:name]] autorelease];
}

+ (CardSymbol *)withImage:(UIImage *)image
{
    return [[[CardSymbol alloc] initWithImage:image] autorelease];
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _symbol = [image retain];
        _cache = [[NSMutableDictionary dictionary] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_cache release];
    [_symbol release];
    [super dealloc];
}

- (UIImage *)imageWithSize:(CGFloat)size color:(UIColor *)color
{
    NSString *key = [NSString stringWithFormat:@"image_%f:%@", size, color];
    UIImage *image = [_cache objectForKey:key];
    
    if ( image != nil )
        return image;

    CGRect rect = CGRectMake(0.0, 0.0, size, size);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
            
    CGImageRef maskRef = _symbol.CGImage; 
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);    

    CGContextTranslateCTM(context, size, size);
    CGContextRotateCTM(context, M_PI);
    CGContextClipToMask(context, rect, mask);
    [color setFill];
    CGContextFillRect(context, rect);
    
    CGImageRelease(mask);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:image forKey:key];
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageWithSize:(CGFloat)size color:(UIColor *)color shadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor
{
    NSString *key = [NSString stringWithFormat:@"image_%f:%@:%f:%f:%@", size, color, shadowOffset.width, shadowOffset.height, shadowColor];
    UIImage *image = [_cache objectForKey:key];
    CGFloat shadowMax = MAX(shadowOffset.width, shadowOffset.height);
    NSLog(@"%f %f %@", shadowOffset.width, shadowOffset.height, shadowColor);
    if ( image != nil )
        return image;
    
    CGRect rect = CGRectMake(0.0, 0.0, size, size);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, shadowOffset, 0, shadowColor.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    
    CGImageRef maskRef = _symbol.CGImage; 
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);    
    
    CGContextTranslateCTM(context, size - shadowMax, size - shadowMax);
    CGContextRotateCTM(context, M_PI);
    CGContextScaleCTM(context, (size - shadowMax) / size, (size - shadowMax) / size);
    CGContextClipToMask(context, rect, mask);
    [color setFill];
    CGContextFillRect(context, rect);
    
    CGImageRelease(mask);
    CGContextEndTransparencyLayer(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    [_cache setObject:image forKey:key];
    
    UIGraphicsEndImageContext();
    
    return image;    
}

@end
