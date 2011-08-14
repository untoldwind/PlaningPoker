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
    }
    
    return self;
}

- (void)dealloc
{
    [_symbol release];
    [super dealloc];
}

- (UIImage *)imageWithSize:(CGFloat)size color:(UIColor *)color
{
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
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageWithSize:(CGFloat)size color:(UIColor *)color shadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor
{
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
    
    CGFloat shadowMax = MAX(shadowOffset.width, shadowOffset.height);
    
    CGContextTranslateCTM(context, size - shadowMax, size - shadowMax);
    CGContextRotateCTM(context, M_PI);
    CGContextScaleCTM(context, (size - shadowMax) / size, (size - shadowMax) / size);
    CGContextClipToMask(context, rect, mask);
    [color setFill];
    CGContextFillRect(context, rect);
    
    CGImageRelease(mask);
    CGContextEndTransparencyLayer(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;    
}

@end
