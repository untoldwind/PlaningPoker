//
//  CardHiddenViewController.h
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 29.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardBackground.h"

@class CardHiddenViewController;

@protocol CardHiddenViewControllerDelegate 
- (void)cardHiddenFinished:(CardHiddenViewController *)controller;

@property (nonatomic) BOOL hideSelectedCard;
@property (nonatomic, readonly) id<CardBackground> currentCardBackground;

@end

@interface CardHiddenViewController : UIViewController

@property (nonatomic, assign) id <CardHiddenViewControllerDelegate> delegate;
@property (nonatomic, assign) id cardValue;

@property (nonatomic, retain) IBOutlet UIButton *revealButton;
@property (nonatomic, retain) IBOutlet UIButton *cardButton;

- (IBAction)reaveal:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
