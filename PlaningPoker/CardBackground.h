//
//  CardBackground.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardBackground : NSObject {
    @private
    CGFloat _border_r, _border_g, _border_b;
    CGFloat _center_r, _center_g, _center_b;
}

@property (nonatomic, readonly) NSString *name;

+ (CardBackground *)withName:(NSString *)name borderR:(CGFloat)border_r borderG:(CGFloat)border_g borderB:(CGFloat)border_b centerR:(CGFloat)center_r centerG:(CGFloat)center_g centerB:(CGFloat)center_b;
- (id)initWithName:(NSString *)name borderR:(CGFloat)border_r borderG:(CGFloat)border_g borderB:(CGFloat)border_b centerR:(CGFloat)center_r centerG:(CGFloat)center_g centerB:(CGFloat)center_b;

- (UIImage *) normal:(CGSize) size;
- (UIImage *) hidden:(CGSize) size;

@end
