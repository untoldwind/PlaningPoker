//
//  CardBackgrounds.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 02.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardBackgrounds.h"

#import "SimpleCardBackground.h"
#import "OCCardBackground.h"

@implementation CardBackgrounds

- (id)init
{
    self = [super init];
    if (self) {
        cardBackgrounds = [[NSMutableArray alloc] initWithCapacity:6];
        
        [cardBackgrounds addObject:[OCCardBackground withName:@"OC"]];
        [cardBackgrounds addObject:[SimpleCardBackground withName:@"Orange" 
                                                   borderR:0.8 borderG:0.4 borderB:0.1 
                                                   centerR:0.9 centerG:0.5 centerB:0.2]];
        [cardBackgrounds addObject:[SimpleCardBackground withName:@"Blue" 
                                                    borderR:0.1 borderG:0.4 borderB:0.8 
                                                    centerR:0.2 centerG:0.5 centerB:0.9]];
        [cardBackgrounds addObject:[SimpleCardBackground withName:@"Green" 
                                                    borderR:0.4 borderG:0.8 borderB:0.1 
                                                    centerR:0.5 centerG:0.9 centerB:0.2]];
        [cardBackgrounds addObject:[SimpleCardBackground withName:@"Yellow" 
                                                    borderR:0.7 borderG:0.7 borderB:0.1 
                                                    centerR:0.8 centerG:0.8 centerB:0.2]];
        [cardBackgrounds addObject:[SimpleCardBackground withName:@"Gray" 
                                                    borderR:0.4 borderG:0.4 borderB:0.4 
                                                    centerR:0.5 centerG:0.5 centerB:0.5]];
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

- (id<CardBackground>)backgroundByIndex:(NSInteger)index
{
    return [cardBackgrounds objectAtIndex:index];
}

@end
