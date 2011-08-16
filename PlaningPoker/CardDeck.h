//
//  CardDeck.h
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDeck : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *cardValues;

+ (id)withName:(NSString *)name cardValues:(NSArray *)cardValues;
- (id)initWithName:(NSString *)name cardValues:(NSArray *)cardValues;

- (NSInteger)numberOfCards;

@end
