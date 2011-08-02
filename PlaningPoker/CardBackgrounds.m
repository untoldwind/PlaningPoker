//
//  CardBackgrounds.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 02.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardBackgrounds.h"

@implementation CardBackgrounds

- (id)init
{
    self = [super init];
    if (self) {
        cardBackgrounds = [[NSMutableArray alloc] initWithCapacity:3];
        
        [cardBackgrounds addObject:[CardBackground withName:@"Orange" 
                                                   borderR:0.8 borderG:0.4 borderB:0.1 
                                                   centerR:0.9 centerG:0.5 centerB:0.2]];
        [cardBackgrounds addObject:[CardBackground withName:@"Blue" 
                                                    borderR:0.1 borderG:0.4 borderB:0.8 
                                                    centerR:0.2 centerG:0.5 centerB:0.9]];
    }
    
    return self;
}

- (void)dealloc
{
    [cardBackgrounds release];
    [super dealloc];
}

- (NSInteger)numberOfBackgrounds
{
    return cardBackgrounds.count;
}

- (CardBackground *)backgroundByIndex:(NSInteger)index
{
    return [cardBackgrounds objectAtIndex:index];
}

@end
