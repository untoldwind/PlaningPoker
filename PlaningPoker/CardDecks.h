//
//  CardDecks.h
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardDeck.h"

@interface CardDecks : NSObject {
    @private
    NSMutableArray *cardDecks;
}

- (NSInteger)numberOfDecks;

- (CardDeck *)deckByIndex:(NSInteger)index;

@end
