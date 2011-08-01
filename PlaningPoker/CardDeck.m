//
//  CardDeck.m
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardDeck.h"

@implementation CardDeck

@synthesize name = _name;
@synthesize cardValues = _cardValues;

+ (id)withName:(NSString *)name cardValues:(NSArray *)cardValues
{
    return [[[CardDeck alloc] initWithName:name cardValues:cardValues] autorelease];
}

- (id)initWithName:(NSString *)name cardValues:(NSArray *)cardValues
{
    self = [super init];
    if (self) {
        _name = [name retain];
        _cardValues = [cardValues retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_name release];
    [_cardValues release];
    [super dealloc];
}

@end
