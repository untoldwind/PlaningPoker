//
//  CardDeckViewController.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardDecks.h"
#import "CardHiddenViewController.h"
#import "SettingsViewController.h"

@interface CardDeckViewController : UIViewController <CardHiddenViewControllerDelegate, SettingsViewControllerDelegate> {
    @private 
    BOOL _hideSelectedCard;
}

@property (nonatomic, readonly) CardDecks *cardDecks;
@property (nonatomic, readonly) CardDeck *currentDeck;
@property (nonatomic) BOOL hideSelectedCard;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *cardButtons;

- (void)setCurrentDeckIndex:(NSInteger)deckIndex;
- (IBAction)selectCard:(id)sender;
- (IBAction)settings:(id)sender;

@end
