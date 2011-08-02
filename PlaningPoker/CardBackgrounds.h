//
//  CardBackgrounds.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 02.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardBackground.h"

@interface CardBackgrounds : NSObject {
    @private
    NSMutableArray *cardBackgrounds;
}

- (NSInteger)numberOfBackgrounds;

- (CardBackground *)backgroundByIndex:(NSInteger)index;

@end
