//
//  SettingsViewController.h
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "CardDecks.h"

@class SettingsViewController;

@protocol SettingsViewControllerDelegate
- (void)settingsFinished:(SettingsViewController *)controller;

@property (nonatomic, readonly) CardDecks *cardDecks;
@property (nonatomic, readonly) CardDeck *currentDeck;

- (IBAction)setCurrentDeckIndex:(NSInteger)deckIndex;
@end

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSInteger selectedDeckIndex;
}

@property (nonatomic, assign) id <SettingsViewControllerDelegate> delegate;

@property (nonatomic, retain) IBOutlet UITableView *cardDeckSelect;

- (IBAction)linkSelected:(id)sender;

- (IBAction)done:(id)sender;

@end
