//
//  CardDeckViewController.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "CardDecks.h"
#import "CardHiddenViewController.h"
#import "SettingsViewController.h"
#import "CardBackgrounds.h"

@interface CardDeckViewController : UIViewController <CardHiddenViewControllerDelegate, SettingsViewControllerDelegate> {
    @private
    UIInterfaceOrientation _orientation;
    NSMutableArray *_cardButtons;
    UIView *_animationView;
    CALayer *_frontLayer, *_backLayer;
    BOOL _hideSelectedCard;
    CGRect _currentFrame;
}

@property (nonatomic, readonly) CardDecks *cardDecks;
@property (nonatomic, readonly) CardDeck *currentDeck;
@property (nonatomic, readonly) CardBackgrounds *cardBackgrounds;
@property (nonatomic, readonly) id <CardBackground> currentCardBackground;
@property (nonatomic) BOOL hideSelectedCard;

- (void)createButtons:(NSInteger)count;
- (void)arrangeButtons;
- (void)setCurrentDeckIndex:(NSInteger)deckIndex;
- (void)setCurrentBackgroundIndex:(NSInteger)backgroundIndex;
- (IBAction)selectCard:(id)sender;
- (IBAction)settings:(id)sender;

@end
