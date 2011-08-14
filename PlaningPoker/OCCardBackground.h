//
//  OCCardBackground.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardBackground.h"

@interface OCCardBackground : NSObject <CardBackground> {
    @private
    CGFloat _bg_r, _bg_g, _bg_b;
}

+ (OCCardBackground *)withName:(NSString *)name bgR:(CGFloat)bg_r bgG:(CGFloat)bg_g bgB:(CGFloat)bg_b;
- (id)initWithName:(NSString *)name bgR:(CGFloat)bg_r bgG:(CGFloat)bg_g bgB:(CGFloat)bg_b;

@end
