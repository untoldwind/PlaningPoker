//
//  SettingsViewController.h
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "CardDecks.h"
#include "CardBackgrounds.h"

@class SettingsViewController;

@protocol SettingsViewControllerDelegate
- (void)settingsFinished:(SettingsViewController *)controller;

@property (nonatomic, readonly) CardDecks *cardDecks;
@property (nonatomic, readonly) CardDeck *currentDeck;
@property (nonatomic, readonly) CardBackgrounds *cardBackgrounds;
@property (nonatomic, readonly) id <CardBackground> currentCardBackground;
@property (nonatomic) BOOL hideSelectedCard;

- (void)setCurrentDeckIndex:(NSInteger)deckIndex;
- (void)setCurrentBackgroundIndex:(NSInteger)backgroundIndex;
@end

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSInteger selectedDeckIndex;
    NSInteger selectedBackgroundIndex;
}

@property (nonatomic, assign) id <SettingsViewControllerDelegate> delegate;

@property (nonatomic, retain) IBOutlet UITableView *cardDeckSelect;

- (void)hideSelectedCardChanged:(id)sender;
- (IBAction)linkSelected:(id)sender;
- (IBAction)done:(id)sender;

@end
