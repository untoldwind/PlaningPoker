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
    NSMutableDictionary *_cache;
}

+ (OCCardBackground *)withName:(NSString *)name;
- (id)initWithName:(NSString *)name;

@end
